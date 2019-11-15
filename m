Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7CFDBF5
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2019 12:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKOLIj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Nov 2019 06:08:39 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:39362 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfKOLIi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Nov 2019 06:08:38 -0500
X-ASG-Debug-ID: 1573816115-0a7b8d16ec2dd250001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.105.111.dyn.edpnet.net [94.105.105.111]) by relay-b02.edpnet.be with ESMTP id X6sRpFa2jDANlGa0; Fri, 15 Nov 2019 12:08:35 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.105.111.dyn.edpnet.net[94.105.105.111]
X-Barracuda-Apparent-Source-IP: 94.105.105.111
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id B6532B24DC0;
        Fri, 15 Nov 2019 12:08:32 +0100 (CET)
Date:   Fri, 15 Nov 2019 12:08:22 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN bitrate and settings readout
Message-ID: <20191115110822.GA19412@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: CAN bitrate and settings readout
Mail-Followup-To: Sean Nyekjaer <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <74972b2d-4580-f3da-b01c-c685680a00ec@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74972b2d-4580-f3da-b01c-c685680a00ec@geanix.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.105.111.dyn.edpnet.net[94.105.105.111]
X-Barracuda-Start-Time: 1573816115
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 292
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5776 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78021
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On vr, 15 nov 2019 12:02:36 +0100, Sean Nyekjaer wrote:
> Hi all,
> 
> Is it possible to read the current setting of bitrate and listen-only for
> our can interfaces?
> 
> It could be nice to see the bitrate and settings when running `ip link`

$ ip -d link show can0

> 
> /Sean
