Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483701B6CC
	for <lists+linux-can@lfdr.de>; Mon, 13 May 2019 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfEMNMy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 May 2019 09:12:54 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:43811 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfEMNMy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 May 2019 09:12:54 -0400
X-ASG-Debug-ID: 1557753170-0a88180930172bc70001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.103.163.adsl.dyn.edpnet.net [77.109.103.163]) by relay-b03.edpnet.be with ESMTP id 515pfPmHGjgkNJYy; Mon, 13 May 2019 15:12:50 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Apparent-Source-IP: 77.109.103.163
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id A3657836875;
        Mon, 13 May 2019 15:12:50 +0200 (CEST)
Date:   Mon, 13 May 2019 15:12:49 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: Re: [PATCH] j1939: transport: seed retry timeout for (E)TP sessions
Message-ID: <20190513131249.GA18228@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] j1939: transport: seed retry timeout for (E)TP sessions
Mail-Followup-To: Oleksij Rempel <o.rempel@pengutronix.de>,
        mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
References: <20190513124427.30997-1-o.rempel@pengutronix.de>
 <304363b3-ff27-f28d-43e6-20a4facd6729@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <304363b3-ff27-f28d-43e6-20a4facd6729@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Start-Time: 1557753170
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 762
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5127 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.71216
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On ma, 13 mei 2019 14:50:10 +0200, Oleksij Rempel wrote:
> Hi folks!
> 
> what do think about this change? Are there better ways to solve it?
> This issue is easy to reproduce if I send 2 (E)TPs in parallel. For example:
> 
> jcat -i /test_100k can0:0x80 :0x90,0x13400 &
> jcat -i /test_100k can0:0x80 :0x91,0x12300 &

Ah, you made it reproducible. 
I considered long time ago this would potentially be an issue, but never
managed to identify it as a source of problem.

I think it's a good improvement,
including the remove of this paramter.

> >  static unsigned int j1939_tp_block = 255;
> >-static unsigned int j1939_tp_retry_ms = 20;
> >  static unsigned int j1939_tp_packet_delay;
> >  static unsigned int j1939_tp_padding = 1;

Kurt
