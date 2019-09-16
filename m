Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C81B4352
	for <lists+linux-can@lfdr.de>; Mon, 16 Sep 2019 23:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfIPVkp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Sep 2019 17:40:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33163 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfIPVkp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Sep 2019 17:40:45 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rsc@pengutronix.de>)
        id 1i9yjj-0007h6-QC; Mon, 16 Sep 2019 23:40:43 +0200
Received: from rsc by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <rsc@pengutronix.de>)
        id 1i9yjj-0003A1-2N; Mon, 16 Sep 2019 23:40:43 +0200
Date:   Mon, 16 Sep 2019 23:40:43 +0200
From:   Robert Schwebel <r.schwebel@pengutronix.de>
To:     "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: J1939 support
Message-ID: <20190916214043.ozk4hivghjpuwu56@pengutronix.de>
References: <e39e2d61-66ad-d3ce-cd1e-5a2245d632a1@iot.bzh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39e2d61-66ad-d3ce-cd1e-5a2245d632a1@iot.bzh>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 23:40:09 up 71 days,  3:50, 64 users,  load average: 0,35, 0,21,
 0,14
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: rsc@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Sep 16, 2019 at 06:41:01PM +0200, Romain Forlot [IoT.bzh] wrote:
> We followed work within linux-can-next repository and more particularly
> about the j1939 branches.
> 
> They have recently been removed from the repository, is it because they will
> be integrated in the mainline kernel ? (Not found ATM in the master branch
> of the stable linux repository)
> 
> Else, where could be found the recent progression on this subject ? Thanks

It is currently in net-next:
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=9d71dd0c70099914fcd063135da3c580865e924c

rsc
-- 
Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
