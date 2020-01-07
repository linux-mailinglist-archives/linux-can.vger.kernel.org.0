Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74089132EFB
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2020 20:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgAGTHB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 7 Jan 2020 14:07:01 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:55393 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGTHA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jan 2020 14:07:00 -0500
X-ASG-Debug-ID: 1578424017-0a7b8d6cdf1519830001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.104.28.adsl.dyn.edpnet.net [77.109.104.28]) by relay-b02.edpnet.be with ESMTP id BLtHRLASy9qXAxDL; Tue, 07 Jan 2020 20:06:57 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.104.28.adsl.dyn.edpnet.net[77.109.104.28]
X-Barracuda-Apparent-Source-IP: 77.109.104.28
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 1A886C2AD08;
        Tue,  7 Jan 2020 20:06:57 +0100 (CET)
Date:   Tue, 7 Jan 2020 20:06:55 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Elenita Hinds <ecathinds@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC v3] c_can: improve latency and avoid packet loss
Message-ID: <20200107190655.GA17976@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [RFC v3] c_can: improve latency and avoid packet loss
Mail-Followup-To: Elenita Hinds <ecathinds@gmail.com>,
        linux-can@vger.kernel.org
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
 <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <CAHChkrviSWcA0KS6jrzfPgE0ygs3tup1GseOeLto6OvLOgH2iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAHChkrviSWcA0KS6jrzfPgE0ygs3tup1GseOeLto6OvLOgH2iw@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.104.28.adsl.dyn.edpnet.net[77.109.104.28]
X-Barracuda-Start-Time: 1578424017
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1036
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9916 1.0000 4.2452
X-Barracuda-Spam-Score: 4.25
X-Barracuda-Spam-Status: No, SCORE=4.25 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79189
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 07 jan 2020 10:58:26 -0600, Elenita Hinds wrote:
> Hi,
> I've been testing version 4 of this patch series on our product and it
> looks good so far (only 1 packet loss at the beginning of each tests
> after hours of run, which is insignificant). On my end, the 64 message
> objects plus setting the TI chip's CPU frequency scaling/governor to
> 'performance' (from ondemand which apparently had issues)  made a huge
> difference.

Thanks for sharing your results. It confirms that it really improved.
> 
> I'm assuming there is no other way to make the RX/TX split configurable?

I understood from Marc on 17 Dec that one would want to avoid large HW
queues.
Making it configurable from Kconfig seems not appropriate.
From device-tree seems possible.
I considered that 8 TX queue is good enough, and assign the
remaining HW space to recv.

I honestly see no reason anymore to make it adustable, other than
that I choose a bad fixed value.
How would you want to make the tx/rx split?

Kind regards,
Kurt
