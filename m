Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118A7135931
	for <lists+linux-can@lfdr.de>; Thu,  9 Jan 2020 13:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgAIM23 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jan 2020 07:28:29 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:40473 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbgAIM23 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jan 2020 07:28:29 -0500
X-ASG-Debug-ID: 1578572905-0a7ff5137d2f35eb0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.104.28.adsl.dyn.edpnet.net [77.109.104.28]) by relay-b01.edpnet.be with ESMTP id 7LkB3S8oVIWB9neD; Thu, 09 Jan 2020 13:28:25 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.104.28.adsl.dyn.edpnet.net[77.109.104.28]
X-Barracuda-Apparent-Source-IP: 77.109.104.28
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 3C77FC33EA7;
        Thu,  9 Jan 2020 13:28:25 +0100 (CET)
Date:   Thu, 9 Jan 2020 13:28:23 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Elenita Hinds <ecathinds@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC v3] c_can: improve latency and avoid packet loss
Message-ID: <20200109122823.GB6633@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [RFC v3] c_can: improve latency and avoid packet loss
Mail-Followup-To: Elenita Hinds <ecathinds@gmail.com>,
        linux-can@vger.kernel.org
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
 <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <CAHChkrviSWcA0KS6jrzfPgE0ygs3tup1GseOeLto6OvLOgH2iw@mail.gmail.com>
 <20200107190655.GA17976@x1.vandijck-laurijssen.be>
 <CAHChkru-9uYo1wrdf8PQUv3AQcsQCag7PR7TCsR3g2xEoHjbzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHChkru-9uYo1wrdf8PQUv3AQcsQCag7PR7TCsR3g2xEoHjbzA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.104.28.adsl.dyn.edpnet.net[77.109.104.28]
X-Barracuda-Start-Time: 1578572905
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 577
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9998 1.0000 4.3411
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79226
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> > On di, 07 jan 2020 10:58:26 -0600, Elenita Hinds wrote:
> > > Hi,
> > > I've been testing version 4 of this patch series on our product and it
> > > looks good so far (only 1 packet loss at the beginning of each tests
> > > after hours of run, which is insignificant). On my end, the 64 message

Would you mind trying to run 'ip link set can0 up' with elevated
priority, ex. 'chrt -f 10 ip link ...' instead?

I had one time the idea that this would help, but it turned out that
this was not the issue I experienced, so I never investiged this
further.

Kurt
