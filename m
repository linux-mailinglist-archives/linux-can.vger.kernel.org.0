Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B546341D15
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 13:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSMmN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 08:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhCSMlr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 08:41:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06913C06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 05:41:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNERl-0002xI-Ko
        for linux-can@vger.kernel.org; Fri, 19 Mar 2021 13:41:45 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5CA745FA963
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 12:41:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 15C895FA960;
        Fri, 19 Mar 2021 12:41:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ef734438;
        Fri, 19 Mar 2021 12:41:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, mailhol.vincent@wanadoo.fr
Subject: [PATCH v13 00/11] Introducing ETAS ES58X CAN USB interfaces
Date:   Fri, 19 Mar 2021 13:41:30 +0100
Message-Id: <20210319124141.247844-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

this my attempt to split the driver into 3 patches, so that it can be
send via mailing lists:
- core support
- es581_4
- es58x_fd

For now I've removed the setting of dql.min_limit, that can be added
back in a later patch, once discussed with upstream netdev. While
working on the code, I've added some typo and kernel doc fixes.

I plan to squash the patches, I've kept them separate for better
illustration.

regards,
Marc



