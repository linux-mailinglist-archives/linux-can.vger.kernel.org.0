Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4974BF722
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 12:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiBVLT4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 06:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiBVLTz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 06:19:55 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Feb 2022 03:19:29 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9ADCEA2D
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 03:19:28 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MF3Y8-1nT82J36LY-00FSnP for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022
 12:14:23 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 5013C3B08B7
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 12:12:17 +0100 (CET)
Message-ID: <93aa0ce4-8df2-bcad-237b-c6ce1bdcff0e@photo-meter.com>
Date:   Tue, 22 Feb 2022 12:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Reply-To: anochin@photo-meter.com
Content-Language: en-US
To:     linux-can@vger.kernel.org
From:   Michael Anochin <anochin@photo-meter.com>
Subject: can: m_can: tcan4x5x m_can_isr do not handle tx if rx fails
Organization: Czibula und Grundmann GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jGoR+s25XrIlENuh3ZsAhbJ6feWOsn5oD13IXGOr7b23sapTKUd
 qkZEL6suv1HfVrsT44ArqEMHsWyVrwKkF09Ai6H4KfyJHJmdiaHNwgJDkrqydXAUoSy+enz
 Y9O3o4qjbopq6DGBLgM3536usB0zMKqHW9LxBwnLJ4KuZ+Yy1bV6m7OMUx2lKsovLrTrdwD
 RxRyeoNg1QKhY+gp3FGCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rwSWLuc384Q=:W+GSF7ckdvoGMFv4htd4Xw
 xIGPKGFbp6AU0pepBkla/fVZ0IUmyDXKhwr9zJEdp46/O+wla/7jGG+QBmcubqXyK4rwchQiP
 jC8D1NkhxcxVhpjfSWFMMG7wQjrTdFFwaEnV6hSrdHu6ogMp08fjJnt0jqMlt8ovJxxaRvCax
 WWUrR7ztZXUXCqHwtnCQ0KgBzmSCI4BXIUPB/4UXPPKkNlFnhtdJa/ErWfp42SMexs6BBglXs
 OJWXyOnosFKdM0yZ4BNzBQKD5yQan5A4QZDXnY3RyXPguTt3UokuRAt+4eDuNWPk8qRGq2uyf
 +o0AhxOLc8/5VD3jCqzmBKAMWCx3WbuAEZrRXJ693LGPQP3IWpPJpZxKBV+K8ATmoQCk64lVQ
 P80jv1bFkLRZNoeToNkOE9HV3dHU751T2AVTw9cI4Pg+Sfx9xyzI422BU0rkZUJd92XLpF36f
 ZjPjoUy+83QxoKm1g30b78KEzHm89auAsbio56nIl3jp70Dsp9/2nfL3vFJFI/SOCw9+ysgrh
 HNcr5A9pYloufq75EEFaCi0VrYT7O7opq3EAgZxQfbN9PuOKCQaQ+cCqU39fnjz0oCLz8ZfCz
 o2UMFXhL8H+AnzNvsvANR2A1bZCDSAe7uu3HS0vhTrtLUe4kEwR7jxqDCGy0Q7lVymDLCca+q
 916Q9Ko1D5Bipq29Zex7jFN6gPUGhmQVMFVc2dAANSBHJeTRG5WQ+M2Sxh1b3Gclx9hITKb7o
 mr9jB/vjiJAiMfKs
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In the context of the ENOBUFS problem by using can interfaces under 
higher load:

In m_can_isr handler, if rx fails (m_can_rx_peripheral), then no 
netif_wake_queue(dev) will be called. Can this lead to ENOBUFS?

