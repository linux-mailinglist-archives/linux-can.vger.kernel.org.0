Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384EA9005F
	for <lists+linux-can@lfdr.de>; Fri, 16 Aug 2019 12:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfHPK7W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Aug 2019 06:59:22 -0400
Received: from mail-relay230.hrz.tu-darmstadt.de ([130.83.156.230]:47439 "EHLO
        mail-relay230.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbfHPK7W (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Aug 2019 06:59:22 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Aug 2019 06:59:21 EDT
Received: from elektron.ikp.physik.tu-darmstadt.de (elektron.ikp.physik.tu-darmstadt.de [130.83.133.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail-relay230.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4690XQ6H8nz43Sk
        for <linux-can@vger.kernel.org>; Fri, 16 Aug 2019 12:52:54 +0200 (CEST)
Received: from hertz (hertz.ikp.physik.tu-darmstadt.de [130.83.133.204])
        by elektron.ikp.physik.tu-darmstadt.de (Postfix) with ESMTP id 8B5F9100AEE
        for <linux-can@vger.kernel.org>; Fri, 16 Aug 2019 12:52:54 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <23894.35590.153840.921485@gargle.gargle.HOWL>
Date:   Fri, 16 Aug 2019 12:52:54 +0200
To:     linux-can@vger.kernel.org
Subject: User-Space Can dongles? Stlink-v3Bridge as CAN dongle
X-Mailer: VM 8.2.0b under 25.3.1 (x86_64-suse-linux-gnu)
From:   bon@elektron.ikp.physik.tu-darmstadt.de
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

STMicroelectronics provides STLINK-V3Set and STLINK-V3Mini ( > 10
Euro) primary for SWD/Jtag debugging via USB. However bridge functions
are implemented for Uart, GPIO, I2C, SPI and CAN. A library (*1) is
provided to use these bridge functions, stacking on some device
library (*2) stacking finally on libusb.

Using these dongles as socket-can adapters would come handy.

However this would imply a user-space socketcan adapter. Is such a
thing possible? 

Any ideas and hints welcome!

(*1)
https://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-programmers/stlink-v3-bridge.html

(*2)
https://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-programmers/stsw-link007.html

-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 1623569 ------- Fax. 06151 1623305 ---------
