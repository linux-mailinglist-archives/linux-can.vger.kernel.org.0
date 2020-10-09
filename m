Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9F288A82
	for <lists+linux-can@lfdr.de>; Fri,  9 Oct 2020 16:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgJIOQv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Oct 2020 10:16:51 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:51100 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgJIOQt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Oct 2020 10:16:49 -0400
X-ASG-Debug-ID: 1602253005-0a7ff508f517df9a0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.104.9.dyn.edpnet.net [94.105.104.9]) by relay-b01.edpnet.be with ESMTP id iVs1kCjuUMWMiFKQ for <linux-can@vger.kernel.org>; Fri, 09 Oct 2020 16:16:45 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.104.9.dyn.edpnet.net[94.105.104.9]
X-Barracuda-Apparent-Source-IP: 94.105.104.9
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id DF5A3109B997
        for <linux-can@vger.kernel.org>; Fri,  9 Oct 2020 16:16:44 +0200 (CEST)
Date:   Fri, 9 Oct 2020 16:16:43 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: mcp2517fd: transmit errors
Message-ID: <20201009141643.GE7238@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: mcp2517fd: transmit errors
Mail-Followup-To: linux-can@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.104.9.dyn.edpnet.net[94.105.104.9]
X-Barracuda-Start-Time: 1602253005
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 446
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9828 1.0000 4.1442
X-Barracuda-Spam-Score: 4.14
X-Barracuda-Spam-Status: No, SCORE=4.14 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.85172
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

I'm using a v5.4 kernel now, with backported 'can: mcp25xxfd: initial commit'.
I did focus up to now to CAN recv performance, but now I face another
issue. I have errors transmitting to CAN. It's unstable.
I need to collect more details, and it is now about focus number 1.

I managed to decrease the urgency for my project by inserting a delay
in the most busy transmitter.

Any ideas what to look for?

Kind regards,
Kurt
