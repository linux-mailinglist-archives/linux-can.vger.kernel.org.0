Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7290C2D4BB4
	for <lists+linux-can@lfdr.de>; Wed,  9 Dec 2020 21:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbgLIUZb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Dec 2020 15:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387524AbgLIUZZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Dec 2020 15:25:25 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C8C0613D6
        for <linux-can@vger.kernel.org>; Wed,  9 Dec 2020 12:24:45 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u19so3025295edx.2
        for <linux-can@vger.kernel.org>; Wed, 09 Dec 2020 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NWzCxmt8ydVHM/+dxflBPJKVBUm+/DapTJJBwEsSxF8=;
        b=TVkV+sdr2o0Zq8H4Yc3A4qc2hzYx0Yxaqstt2PJCYZyzdmwaYFHTFbublew327qYtf
         SPY7JgeJDDl7Wwp+qOheQWvYOqVNhsO4KQv80q/n4Q0Ll3sN7KCc9tmIBl8IbEjJLcNv
         IQxGnITLwqeSzP83xtPCgXNH0sGCI9w94Hckz8Pj5CMm4Mvqioqceh+oU8edPNEryit9
         Ji5ZVuvsAY4GfgJe20Il7TeQhrIpO8V76exQ2QwR5IH7AXdJ8xZ5R9LfeBt33Fh3OrVH
         00q+AVhibs44sVhqUclJn+nrtohvfZlmPynDFAIg6xYw4TwyCUZGv5dk18ylfOkS4iFA
         uvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWzCxmt8ydVHM/+dxflBPJKVBUm+/DapTJJBwEsSxF8=;
        b=SkUXL5WVa4OqXECo0YUVwQCJt2hNUuIxv9CVQsotNNdADFthK7TGM1awNyTI4CAs+i
         9PczSDZayLRpzcxSdrQAcoq8eH61p61rQaCmZdsWUs1MNXo1Dq1+g4zynXTQ+hj5bqAE
         dEoGWKFzPig/XHyBQ+kbOvuRgiQfvWkIlYKCgzl9Aj0/Kh3q36Pwr7VRF3Cv41MyZx8p
         VyGPHFPfh9AudfkEGdysk4bl2X2x3Gc4z02ZjC2OCYIoGT6EqtuVJDfT4Vzhk5uj2Ina
         i21AXpwd3nXjoghlv3TNWbv4CCLK/yqEPYbFcUO23y0/C5kX1c1h/RqjGneCobWxUBbT
         DqRg==
X-Gm-Message-State: AOAM532pSLUyVljJZDURukE5Khyt/xnbUAHqkIy1Fav0+UVbBxIqP9u+
        Aq8N45Bx1THQgT6/vYSjTTPTgBqBYtHz2bnS3jY=
X-Google-Smtp-Source: ABdhPJzrwKAJf/5jCBrPzslHTmdnPvZp+Ik74HRNc8WVYmNEt3mK/loKwjGU/DD8JOHtKFueAW0+6FzsK4RImUlx3EA=
X-Received: by 2002:a05:6402:2074:: with SMTP id bd20mr3601664edb.326.1607545483526;
 Wed, 09 Dec 2020 12:24:43 -0800 (PST)
MIME-Version: 1.0
References: <CABxGUThzGkCerMBTuA95TCs49hjHg+O-u3Z_c8=RZGJ8bVQjRQ@mail.gmail.com>
 <a13ab81e-ad20-0405-6935-ecd748233bc5@pengutronix.de>
In-Reply-To: <a13ab81e-ad20-0405-6935-ecd748233bc5@pengutronix.de>
From:   Christian Gagneraud <chgans@gmail.com>
Date:   Thu, 10 Dec 2020 09:24:31 +1300
Message-ID: <CABxGUTjcynztDDoB=OVAXa4SYig3Ju+Y8wHmg-oVxs-b5n2SqA@mail.gmail.com>
Subject: Re: New USB driver, looking for advice
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 9 Dec 2020 at 03:59, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 12/7/20 3:57 AM, Christian Gagneraud wrote:
> > I'm looking at creating a new CAN driver for a USB device [1]. This device
> > has a custom protocol over bulk endpoints. I was able to create a simple
> > driver, based on usb-skeleton.c that allows to speak this protocol by opening
> > a custom har device.
>
> Do you already have code available somewhere?

No, not yet. This driver is really a slightly modified usb-skeleton
where you read/write bulk packets one by one on a char device.
I have as well a python version that was used as a proof of concept
(using pyusb).

>
> > I've been looking at the current implementation in [2], I think my device is
> > a bit special, you cannot read CAN frames w/o sending a 'read' command, so i
> > need some sort of polling. AFAIK, the Linux USB stack provides that for me,
> > except that the device won't read anything unless you send it a command.
>
> I don't know if you have to implement the polling yourself or if there is a
> polling helper. I'll ask my co-workers.
>
> Is that a Interrupt Transfer Endpoint or a normal Bulk Endpoint?

AFAIU the firmware, it's just a normal Bulk Endpoint, which i think is
the problem.

> > I have the feeling that current drivers are for devices that can
> > return data by just scheduling read transfer.
>
> Yes. Current drivers get notified by the device, if there is a CAN frame waiting.
>
> > Anyone would have a clue on how these drivers work, and if my device
> > is really that special?
>
> Yes, your device is quite special :)

Hum, no good news...

The device has 3 interfaces:
- keyboard
- mouse
- device specific (CAN)

The reason for HID is that these sort of devices[1] communicate over N2K
[1] https://www.simrad-yachting.com/en-nz/simrad/type/autopilots/autopilot-remote-controllers/simrad-op50-remote/

Thanks,
Chris

$ lsusb -v
Bus 001 Device 105: ID 1cda:03e8
Device Descriptor:
 bLength                18
 bDescriptorType         1
 bcdUSB               2.00
 bDeviceClass            0 (Defined at Interface level)
 bDeviceSubClass         0
 bDeviceProtocol         0
 bMaxPacketSize0        64
 idVendor           0x1cda
 idProduct          0x03e8
 bcdDevice            0.13
 iManufacturer           1 Navico Asia Pacific Ltd
 iProduct                2 Navico USB IO Computer
 iSerial                 3 SN-03EC-FFFFFFFF
 bNumConfigurations      1
 Configuration Descriptor:
   bLength                 9
   bDescriptorType         2
   wTotalLength           82
   bNumInterfaces          3
   bConfigurationValue     1
   iConfiguration          0
   bmAttributes         0x80
     (Bus Powered)
   MaxPower              100mA
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        0
     bAlternateSetting       0
     bNumEndpoints           1
     bInterfaceClass         3 Human Interface Device
     bInterfaceSubClass      1 Boot Interface Subclass
     bInterfaceProtocol      1 Keyboard
     iInterface              4 Virtual Keyboard
       HID Device Descriptor:
         bLength                 9
         bDescriptorType        33
         bcdHID               1.01
         bCountryCode            0 Not supported
         bNumDescriptors         1
         bDescriptorType        34 Report
         wDescriptorLength      63
        Report Descriptors:
          ** UNAVAILABLE **
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x81  EP 1 IN
       bmAttributes            3
         Transfer Type            Interrupt
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0008  1x 8 bytes
       bInterval              10
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        1
     bAlternateSetting       0
     bNumEndpoints           1
     bInterfaceClass         3 Human Interface Device
     bInterfaceSubClass      1 Boot Interface Subclass
     bInterfaceProtocol      2 Mouse
     iInterface              5 Virtual Mouse
       HID Device Descriptor:
         bLength                 9
         bDescriptorType        33
         bcdHID               1.01
         bCountryCode            0 Not supported
         bNumDescriptors         1
         bDescriptorType        34 Report
         wDescriptorLength      50
        Report Descriptors:
          ** UNAVAILABLE **
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x84  EP 4 IN
       bmAttributes            3
         Transfer Type            Interrupt
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0008  1x 8 bytes
       bInterval              10
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        2
     bAlternateSetting       0
     bNumEndpoints           2
     bInterfaceClass       255 Vendor Specific Class
     bInterfaceSubClass    255 Vendor Specific Subclass
     bInterfaceProtocol    255 Vendor Specific Protocol
     iInterface              6 Client Application Interface
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x82  EP 2 IN
       bmAttributes            2
         Transfer Type            Bulk
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0040  1x 64 bytes
       bInterval               0
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x02  EP 2 OUT
       bmAttributes            2
         Transfer Type            Bulk
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0040  1x 64 bytes
       bInterval               0
Device Status:     0x0000
 (Bus Powered)
