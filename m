Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2543D381A95
	for <lists+linux-can@lfdr.de>; Sat, 15 May 2021 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhEOSn4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 15 May 2021 14:43:56 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:50878 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhEOSny (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 May 2021 14:43:54 -0400
X-ASG-Debug-ID: 1621104158-15c4341e04159bb70001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.122.62.dyn.edpnet.net [94.105.122.62]) by relay-b01.edpnet.be with ESMTP id QqGrvTEkqzQ2zJpf; Sat, 15 May 2021 20:42:38 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.122.62.dyn.edpnet.net[94.105.122.62]
X-Barracuda-Apparent-Source-IP: 94.105.122.62
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 5B78F141C34C;
        Sat, 15 May 2021 20:42:38 +0200 (CEST)
Date:   Sat, 15 May 2021 20:42:37 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: J1939 Questions on Intended usage
Message-ID: <20210515184237.GD2387@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: J1939 Questions on Intended usage
Mail-Followup-To: Patrick Menschel <menschel.p@posteo.de>,
        linux-can <linux-can@vger.kernel.org>
References: <f0d77797-c485-2f88-57e3-b5c7b4953706@posteo.de>
 <20210515122611.GC2387@x1.vandijck-laurijssen.be>
 <38c85980-a569-b714-2643-9623b3dbc973@posteo.de>
 <72aa8b79-5ba9-26ee-3918-09532e0f1eae@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72aa8b79-5ba9-26ee-3918-09532e0f1eae@posteo.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.122.62.dyn.edpnet.net[94.105.122.62]
X-Barracuda-Start-Time: 1621104158
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 519
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.89960
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, 15 May 2021 18:10:20 +0000, Patrick Menschel wrote:
> Am 15.05.21 um 16:01 schrieb Patrick Menschel:
> > Am 15.05.21 um 14:26 schrieb Kurt Van Dijck:
> >> On Fri, 14 May 2021 12:04:47 +0000, Patrick Menschel wrote:
> >>> Do I need to open one socket per PGN I'm sending?
> >>> e.g.
> >>>
> Guess I have to amend that impression, everything works fine,
> except for broadcast which gives me a PermissionError ?!

Will you not forget to set the SO_BROADCAST socket option ( see: man 7 socket )

Kurt
