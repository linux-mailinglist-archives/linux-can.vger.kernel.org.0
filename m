Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D904425FABF
	for <lists+linux-can@lfdr.de>; Mon,  7 Sep 2020 14:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgIGMxB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Sep 2020 08:53:01 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:57726 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgIGMw0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Sep 2020 08:52:26 -0400
X-Greylist: delayed 1093 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2020 08:52:25 EDT
X-ASG-Debug-ID: 1599482039-0a7ff516007298d0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.65.adsl.dyn.edpnet.net [77.109.119.65]) by relay-b01.edpnet.be with ESMTP id c7pA46IDNvqzkT87; Mon, 07 Sep 2020 14:33:59 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.65.adsl.dyn.edpnet.net[77.109.119.65]
X-Barracuda-Apparent-Source-IP: 77.109.119.65
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 61460101A9C3;
        Mon,  7 Sep 2020 14:33:59 +0200 (CEST)
Date:   Mon, 7 Sep 2020 14:33:56 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     tom_usenet@optusnet.com.au,
        henrique ricardo figueira <henrislip@gmail.com>,
        linux-can@vger.kernel.org
Subject: Re: Questions about using multiple sockets
Message-ID: <20200907123356.GA15060@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: Questions about using multiple sockets
Mail-Followup-To: Oliver Hartkopp <socketcan@hartkopp.net>,
        tom_usenet@optusnet.com.au,
        henrique ricardo figueira <henrislip@gmail.com>,
        linux-can@vger.kernel.org
References: <CAD1tVCN7-T=FHNQEz3Bp-0Kt3H6M1RokyUuw=e9sTLdXNWB=DQ@mail.gmail.com>
 <20200903054724.x6giher7ldmuvbac@pengutronix.de>
 <1116be40-25c4-002e-8455-5d5f86ac6e03@optusnet.com.au>
 <ebbe3d01-f36b-78e5-3a73-eee7f868b464@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebbe3d01-f36b-78e5-3a73-eee7f868b464@hartkopp.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.65.adsl.dyn.edpnet.net[77.109.119.65]
X-Barracuda-Start-Time: 1599482039
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 274
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9947 1.0000 4.2819
X-Barracuda-Spam-Score: 4.28
X-Barracuda-Spam-Status: No, SCORE=4.28 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.84464
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> 
> The 'problem' seems to be already introduced by that specific ECU ;-)

In my experience, it's hard to use 29bit CAN id's mixed with J1939.
But the 11bit CAN id range is free to use without any conflict with
j1939.
I've seen some uses of this 11bit id's.

Kurt
