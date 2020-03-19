Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F077618B947
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2020 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCSOVO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Mar 2020 10:21:14 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:34748 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCSOVN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Mar 2020 10:21:13 -0400
X-Greylist: delayed 1177 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 10:21:12 EDT
X-ASG-Debug-ID: 1584626493-0a7b8d16c824a440001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be ([77.109.89.38]) by relay-b02.edpnet.be with ESMTP id pWFS2zK69yfKbf5d; Thu, 19 Mar 2020 15:01:33 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[77.109.89.38]
X-Barracuda-Apparent-Source-IP: 77.109.89.38
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id E4D51D897CD;
        Thu, 19 Mar 2020 15:01:32 +0100 (CET)
Date:   Thu, 19 Mar 2020 15:01:27 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: PCI/PCIe cards and MSI support
Message-ID: <20200319140127.GD2538@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: PCI/PCIe cards and MSI support
Mail-Followup-To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: UNKNOWN[77.109.89.38]
X-Barracuda-Start-Time: 1584626493
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 249
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9994 1.0000 4.3361
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.80705
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey,

> or if the driver can decide to request (resp. free) IRQs when loading (resp. unloading)
> the module?

This seems a bad idea. Loading the module should not allocate resources.
A reasonable point IMHO is the probe of a device.

Kurt
