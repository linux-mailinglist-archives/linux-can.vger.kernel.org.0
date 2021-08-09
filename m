Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C4C3E413F
	for <lists+linux-can@lfdr.de>; Mon,  9 Aug 2021 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhHIH72 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Aug 2021 03:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhHIH72 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Aug 2021 03:59:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABD4C0613D3
        for <linux-can@vger.kernel.org>; Mon,  9 Aug 2021 00:59:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mD0Be-00057X-PX
        for linux-can@vger.kernel.org; Mon, 09 Aug 2021 09:59:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C4F696630E9
        for <linux-can@vger.kernel.org>; Mon,  9 Aug 2021 07:59:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2EDA76630E5;
        Mon,  9 Aug 2021 07:59:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8b53018e;
        Mon, 9 Aug 2021 07:59:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, socketcan@esd.eu,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Subject: [PATCH v2] =?UTF-8?q?mailmap:=20update=20email=20address=20of=20M?= =?UTF-8?q?atthias=20Fuchs=20and=20Thomas=20K=C3=B6rper?=
Date:   Mon,  9 Aug 2021 09:59:02 +0200
Message-Id: <20210809075902.170694-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Matthias Fuchs's and Thomas Körper's email addresses aren't valid
anymore. Use the newly created role account instead.

Cc: socketcan@esd.eu
Cc: Stefan Mätje <Stefan.Maetje@esd.eu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v1:
- also replace Thomas Körper's email

 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index a35ae244dfda..eb3f7da2959a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -330,6 +330,8 @@ Shuah Khan <shuah@kernel.org> <shuahkh@osg.samsung.com>
 Shuah Khan <shuah@kernel.org> <shuah.kh@samsung.com>
 Simon Arlott <simon@octiron.net> <simon@fire.lp0.eu>
 Simon Kelley <simon@thekelleys.org.uk>
+<socketcan@esd.eu> <matthias.fuchs@esd.eu>
+<socketcan@esd.eu> <thomas.koerper@esd.eu>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <shemminger@osdl.org>
 Steve Wise <larrystevenwise@gmail.com> <swise@chelsio.com>
-- 
2.30.2


