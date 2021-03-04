Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFE132D757
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 17:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhCDQEg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Mar 2021 11:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbhCDQEP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Mar 2021 11:04:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A24C06175F
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 08:03:34 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHqRp-0006DJ-Bo
        for linux-can@vger.kernel.org; Thu, 04 Mar 2021 17:03:33 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 491B45EDDB7
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 16:03:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7A0C25EDDAB;
        Thu,  4 Mar 2021 16:03:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d0daf3b3;
        Thu, 4 Mar 2021 16:03:29 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: [can-next 0/6] various mcp251xfd improvements
Date:   Thu,  4 Mar 2021 17:03:22 +0100
Message-Id: <20210304160328.2752293-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
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

this series adds support for dev coredump. The in case of fatal errors
the controller will dump the controller contents and some internal
state, which can be analyzed with the mcp251xfd-dump tool of
can-utils.

Further the UINC handling is simplified

The last three patches add support for HW timestamps.

regards
Marc



