Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12E92C5E0
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2019 13:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfE1Lyk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 May 2019 07:54:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52167 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfE1Lyk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 May 2019 07:54:40 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hVagf-0004Cf-7D; Tue, 28 May 2019 13:54:37 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hVagd-0005eu-Vl; Tue, 28 May 2019 13:54:35 +0200
Date:   Tue, 28 May 2019 13:54:35 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        robin@protonic.nl, david@protonic.nl
Subject: j1939: control messages and PGN
Message-ID: <20190528115435.GA7453@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:45:00 up 4 days, 17:47, 110 users,  load average: 14.81, 18.40,
 19.50
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

when receiving j1939 control messages, the current code looks up the
session by DA and SA only, not taking the PGN (which is part of the
control messages' data) into account.

When it comes to error control messages the session is aborted, even if
the PGN doesn't match. In EOMA the session is aborted, too. This means
receiving control messages with non matching PGNs lead to session abort.

Is this in general a good behavior?

regards,
Oleksij & Marc

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
