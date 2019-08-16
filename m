Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6FA901EC
	for <lists+linux-can@lfdr.de>; Fri, 16 Aug 2019 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfHPMrc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Aug 2019 08:47:32 -0400
Received: from mail-relay152.hrz.tu-darmstadt.de ([130.83.252.152]:51206 "EHLO
        mail-relay152.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727104AbfHPMrb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Aug 2019 08:47:31 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2019 08:47:30 EDT
Received: from elektron.ikp.physik.tu-darmstadt.de (elektron.ikp.physik.tu-darmstadt.de [130.83.133.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail-relay152.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4692tR6nz8z43pC;
        Fri, 16 Aug 2019 14:38:39 +0200 (CEST)
Received: from hertz (hertz.ikp.physik.tu-darmstadt.de [130.83.133.204])
        by elektron.ikp.physik.tu-darmstadt.de (Postfix) with ESMTP id A79B0100AEE;
        Fri, 16 Aug 2019 14:38:39 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23894.41935.398091.806166@gargle.gargle.HOWL>
Date:   Fri, 16 Aug 2019 14:38:39 +0200
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     bon@elektron.ikp.physik.tu-darmstadt.de, linux-can@vger.kernel.org
Subject: Re: User-Space Can dongles? Stlink-v3Bridge as CAN dongle
In-Reply-To: <a3ab86b1-12da-9ca3-899d-8385e6a332dc@pengutronix.de>
References: <23894.35590.153840.921485@gargle.gargle.HOWL>
        <a3ab86b1-12da-9ca3-899d-8385e6a332dc@pengutronix.de>
X-Mailer: VM 8.2.0b under 25.3.1 (x86_64-suse-linux-gnu)
From:   bon@elektron.ikp.physik.tu-darmstadt.de
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc Kleine-Budde writes:
> On 8/16/19 12:52 PM, bon@elektron.ikp.physik.tu-darmstadt.de wrote:
> > STMicroelectronics provides STLINK-V3Set and STLINK-V3Mini ( > 10
> > Euro) primary for SWD/Jtag debugging via USB. However bridge functions
> > are implemented for Uart, GPIO, I2C, SPI and CAN. A library (*1) is
> > provided to use these bridge functions, stacking on some device
> > library (*2) stacking finally on libusb.
> 
> What do you mean by bridge functions?

Bridge is what STM call this function. They describe is as
"The bridge API (STLINK-V3-BRIDGE) is a set of source files allowing
the development of personal computer applications exercising the
STLINK-V3 bridge interface of a target board."

It is normal USB communication, with the basic USB protocol
hidden/abstracted by a library.

> 
> In a proper designed system, you want to have UART, GPIO, I2C, SPI and
> CAN drivers in the kernel, not implemented in user space.
>
This would imply the USB protocol open or reverse engineered or
leaked. For the JTAG/SWD part this is already done (OpenOCD, pyOCD,
blackmagic debug probe), also only in user space. For the "bridge
functions there are not (yet?) open specifications.

> > Using these dongles as socket-can adapters would come handy.
> 
> Does the license allow you to cerate any open source software with it?
>
https://www.st.com/content/ccc/resource/legal/legal_agreement/license_agreement/group0/87/0c/3d/ad/0a/ba/44/26/DM00216740/files/DM00216740.pdf/jcr:content/translations/en.DM00216740.pdf

looks like.

> > However this would imply a user-space socketcan adapter. Is such a
> > thing possible? 
> 
> Create a vcan and attach your userspace components to it.
> 

Is there some example code doing something similar?

Thanks
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 1623569 ------- Fax. 06151 1623305 ---------
