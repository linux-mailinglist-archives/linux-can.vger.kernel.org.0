Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6EB2DC7B8
	for <lists+linux-can@lfdr.de>; Fri, 18 Oct 2019 16:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410469AbfJROte (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Oct 2019 10:49:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36995 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfJROte (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Oct 2019 10:49:34 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rsc@pengutronix.de>)
        id 1iLTZM-00088k-Vk; Fri, 18 Oct 2019 16:49:32 +0200
Received: from rsc by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <rsc@pengutronix.de>)
        id 1iLTZM-0002hc-C8; Fri, 18 Oct 2019 16:49:32 +0200
Date:   Fri, 18 Oct 2019 16:49:32 +0200
From:   Robert Schwebel <r.schwebel@pengutronix.de>
To:     "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: Questions around J1939 backport to old kernel
Message-ID: <20191018144932.kipdgmmvdciucfcw@pengutronix.de>
References: <b2dd08f0-0390-21c8-83c5-c6c361e78d9c@iot.bzh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2dd08f0-0390-21c8-83c5-c6c361e78d9c@iot.bzh>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:48:53 up 102 days, 20:59, 81 users,  load average: 0,08, 0,20,
 0,19
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: rsc@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Oct 18, 2019 at 12:07:34PM +0200, Romain Forlot [IoT.bzh] wrote:
> I am wondering what the cost is to backport the j1939 module to an old
> version like a v4.14 LTSI version.
> 
> And what the impact is of backporting the whole CAN stack on the CAN drivers
> ? Are there any modifications to drivers once the CAN stack is updated ?

Could you start using & testing it on current mainline kernels?

rsc
-- 
Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
