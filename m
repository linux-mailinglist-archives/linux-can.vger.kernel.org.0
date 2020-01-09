Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF42136182
	for <lists+linux-can@lfdr.de>; Thu,  9 Jan 2020 21:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgAIUDi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jan 2020 15:03:38 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:55990 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgAIUDi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jan 2020 15:03:38 -0500
X-ASG-Debug-ID: 1578600215-0a7ff5137d2f8c060001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.104.28.adsl.dyn.edpnet.net [77.109.104.28]) by relay-b01.edpnet.be with ESMTP id aCZF7qO2B6CDuv2i; Thu, 09 Jan 2020 21:03:35 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.104.28.adsl.dyn.edpnet.net[77.109.104.28]
X-Barracuda-Apparent-Source-IP: 77.109.104.28
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 4F32FC36217;
        Thu,  9 Jan 2020 21:03:35 +0100 (CET)
Date:   Thu, 9 Jan 2020 21:03:34 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-input@vger.kernel.org
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC] input: cap11xx: plasma globe proof
Message-ID: <20200109200334.GA19438@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [RFC] input: cap11xx: plasma globe proof
Mail-Followup-To: linux-input@vger.kernel.org, linux-can@vger.kernel.org
References: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.104.28.adsl.dyn.edpnet.net[77.109.104.28]
X-Barracuda-Start-Time: 1578600215
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 814
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9963 1.0000 4.2994
X-Barracuda-Spam-Score: 4.30
X-Barracuda-Spam-Status: No, SCORE=4.30 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79234
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Ping?

On zo, 29 dec 2019 20:21:11 +0100, Kurt Van Dijck wrote:
> Hey,
> 
> I built a raspberry-pi wakeup for my kids. Recently, one of them bought
> a plasma globe. That globe leaves an electrostatic field that disturbes
> the cap11xx when it operates with default settings.
> So I grabbed the datasheet and started modifying the configuration.
> This is the result that should apply to other scenarios as well.
> 
> The patch series improves the cap11xx in 2 ways.
> It adds support for a cap1208 as on the explorer hat of Pimoroni,
> and allows to run in polling mode (the explorer hat omitted the irq,
> or I didn't find it).
> It then exposes the major configuration parts of the chip so one can
> tune it to her/his needs.
> 
> Please feel free to comment
> 
> Kind regards,
> Kurt
> 
