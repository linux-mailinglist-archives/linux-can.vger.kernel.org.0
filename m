Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD52B4EB6F
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2019 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUPBM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 21 Jun 2019 11:01:12 -0400
Received: from lipowsky.de ([188.68.49.8]:58606 "EHLO mail.lipowsky.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUPBM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 21 Jun 2019 11:01:12 -0400
Received: from ucs.lipieda.local (p57bfa984.dip0.t-ipconnect.de [87.191.169.132])
        by mail.lipowsky.de (Postfix) with ESMTPS id 677CF40869
        for <linux-can@vger.kernel.org>; Fri, 21 Jun 2019 17:01:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by ucs.lipieda.local (Postfix) with ESMTP id 2DB6A71025FB
        for <linux-can@vger.kernel.org>; Fri, 21 Jun 2019 17:01:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.10.1 (20141025) (Debian) at lipieda.local
Received: from ucs.lipieda.local ([127.0.0.1])
        by localhost (ucs.lipieda.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z3WYVxvuvitz for <linux-can@vger.kernel.org>;
        Fri, 21 Jun 2019 17:01:09 +0200 (CEST)
Received: from ucs.lipieda.local (localhost [127.0.0.1])
        by ucs.lipieda.local (Postfix) with ESMTP id CEDFE71025F9
        for <linux-can@vger.kernel.org>; Fri, 21 Jun 2019 17:01:09 +0200 (CEST)
Received: by ucs (kopano-spooler) with MAPI; Fri, 21 Jun 2019 17:01:09 +0200
Subject: at91: link CAN set down problem
From:   =?utf-8?Q?Efim_Monjak?= <emonjak@lipowsky.de>
To:     =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= 
        <linux-can@vger.kernel.org>
Date:   Fri, 21 Jun 2019 17:01:09 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.3.1-35
X-Original-To: 
Message-Id: <kcim.5d0cf135.3242.22f1433070581667@ucs.lipieda.local>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

I am using Linux 4.4 on SAMA5D3 MPU to run an application written in C.
Sometimes this application must switch off a MPU CAN controller.
It will be done by putting a "/sbin/ip link set CAN0 down" string in a pipe.
This cause a call of at91_close() function in at91_can.c driver.
If MPU is only one CAN node on the bus it retransmitts frame to send due
noACK error.
Sometimes after switch off CAN controler by at91_close() function
the CAN bus remains dominant.
It can be prevented by adding a delay before clk_disable_unprepare() call
in at91_close() function.

Waiting for AT91_MR_CANEN bit cleared don't help.

Does anyone have had such problem?

Best regards,
Efim



