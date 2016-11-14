package org.intermine.api.beans;

/*
 * Copyright (C) 2002-2016 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.awt.Image;
import java.beans.BeanDescriptor;
import java.beans.BeanInfo;
import java.beans.EventSetDescriptor;
import java.beans.IntrospectionException;
import java.beans.MethodDescriptor;
import java.beans.PropertyDescriptor;

/**
 * An object that describes the SyntenyObjectDetails bean and supports DWR serialization. Providing
 * this class means DWR will not need to do reflection.
 * @author Vivek Krishnakumar
 *
 */
public class SyntenyObjectDetailsBeanInfo implements BeanInfo
{

    @Override
    public BeanDescriptor getBeanDescriptor() {
        return new BeanDescriptor(SyntenyObjectDetails.class);
    }

    @Override
    public EventSetDescriptor[] getEventSetDescriptors() {
        return new EventSetDescriptor[0];
    }

    @Override
    public int getDefaultEventIndex() {
        return 0;
    }

    @Override
    public PropertyDescriptor[] getPropertyDescriptors() {
        try {
            return new PropertyDescriptor[]{
                new PropertyDescriptor("type", SyntenyObjectDetails.class),
                new PropertyDescriptor("sourceRegion", SyntenyObjectDetails.class),
                new PropertyDescriptor("targetRegion", SyntenyObjectDetails.class)
            };
        } catch (IntrospectionException e) {
            throw new IllegalStateException("SyntenyObjectDetails is missing some properties");
        }
    }

    @Override
    public int getDefaultPropertyIndex() {
        return 0;
    }

    @Override
    public MethodDescriptor[] getMethodDescriptors() {
        return new MethodDescriptor[0];
    }

    @Override
    public BeanInfo[] getAdditionalBeanInfo() {
        return new BeanInfo[0];
    }

    @Override
    public Image getIcon(int iconKind) {
        return null;
    }

}
