Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97493380B
	for <lists+linux-can@lfdr.de>; Mon,  3 Jun 2019 20:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFCSf3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 3 Jun 2019 14:35:29 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:38027 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfFCSf2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 Jun 2019 14:35:28 -0400
X-ASG-Debug-ID: 1559586925-0a7ff511012dfc720001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.103.163.adsl.dyn.edpnet.net [77.109.103.163]) by relay-b01.edpnet.be with ESMTP id mWy1AXbRtBGf5FKV; Mon, 03 Jun 2019 20:35:25 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Apparent-Source-IP: 77.109.103.163
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 3ACCB889668;
        Mon,  3 Jun 2019 20:35:25 +0200 (CEST)
Date:   Mon, 3 Jun 2019 20:35:23 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Cc:     linux-can@vger.kernel.org
Subject: Re: J1939 in AGL
Message-ID: <20190603183523.GA10222@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: J1939 in AGL
Mail-Followup-To: "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>,
        linux-can@vger.kernel.org
References: <ede28202-7be2-5a2f-bc17-4f3af02471bf@iot.bzh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ede28202-7be2-5a2f-bc17-4f3af02471bf@iot.bzh>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Start-Time: 1559586925
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1516
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5007 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.72202
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On ma, 03 jun 2019 18:25:03 +0200, Romain Forlot [IoT.bzh] wrote:
> Hi,
> 
> We are working to support the J1939 protocol, using your works on socketCAN,
> in AGL (Automotive Grade Linux). We are facing some problems or questions
> about how to use it. We still have support for LTSI Kernel which is 4.14 by
> now and certainly will be 4.19 for the next and your work are based on the
> latest Linux v5.1 version.
> 
> Backporting them to 4.19 seems easy, we just took the diff at the head of
> the "j1939" branch of linux-can-next repository as patches and applied them
> to the mainline 4.19 Kernel. We did the same about the 4.14 but only took
> the J1939 relative patches with a slight change on drivers/net/can/dev.c
> patches in the patches implementing the CAN midlayer private.
> 
> Is it planned to support the 4.19 version in the future as it seems to be
> the next LTSI version ? And less probable, do you planned for 4.14 the
> actual LTSI ?
> 
> What do you think about the way we did to backport the work on J1939 ?
> Runtime tests aren't been ran for now but we just prove that patches apply,
> which is not enough for sure, but as the work are limited to the J1939
> module then we are relatively confident and would appreciate your feedback.

You could, as an intermediate step between 'patch apply' and 'runtime tests',
try to compile the kernel with j1939.
Most of the backporting I did in the past indicated the amount of work
during compiling.

Kind regards,
Kurt
