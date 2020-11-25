Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F42C427D
	for <lists+linux-can@lfdr.de>; Wed, 25 Nov 2020 15:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgKYOx4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Nov 2020 09:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbgKYOx4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2020 09:53:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC2DC0613D4
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2020 06:53:55 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1khwB8-0004AH-JU
        for linux-can@vger.kernel.org; Wed, 25 Nov 2020 15:53:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B1CEC59B91A
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2020 14:53:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 75B6859B917;
        Wed, 25 Nov 2020 14:53:53 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 41479c34;
        Wed, 25 Nov 2020 14:53:52 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: [net-next 0/3] tef-path: reduce number of SPI core requests to set UINC bit
Date:   Wed, 25 Nov 2020 15:52:19 +0100
Message-Id: <20201125145221.22241-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
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

as Thomas wants to test the rx-path improvements, here is the same idea for the
TEF-path.

This is a short series to reduce the number SPI core requests to increment the
UINC bit after TEF handling. This is done by chaining the individual UINC bit
changes into a single SPI message consisting of several transfers.

I'll add proper commit messages to patch 1 and 2 later.

Happy testing,
Marc

