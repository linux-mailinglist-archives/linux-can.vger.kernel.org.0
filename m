Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39CD0BBB
	for <lists+linux-can@lfdr.de>; Wed,  9 Oct 2019 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfJIJsv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Oct 2019 05:48:51 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:34575 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIJsv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Oct 2019 05:48:51 -0400
X-ASG-Debug-ID: 1570614523-0a7b8d13bf1a17c0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b02.edpnet.be with ESMTP id GHJH5HbOHYlSwTbd for <linux-can@vger.kernel.org>; Wed, 09 Oct 2019 11:48:43 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 391B1A4C923
        for <linux-can@vger.kernel.org>; Wed,  9 Oct 2019 11:48:43 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: [PATCH] c_can using rx-offload
Date:   Wed,  9 Oct 2019 11:48:32 +0200
X-ASG-Orig-Subj: [PATCH] c_can using rx-offload
Message-Id: <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <20191009074338.GA23530@x1.vandijck-laurijssen.be>
References: <20191009074338.GA23530@x1.vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570614523
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 343
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6501 1.0000 1.0221
X-Barracuda-Spam-Score: 1.02
X-Barracuda-Spam-Status: No, SCORE=1.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77241
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch series reduces the number of locks on the rx-offload skb_queue,
by using a secondary irq_skb_queue, which is appended all-at-once
at the end.
A seconds improvement for c_can is that the tx echo uses the same
path to enter the system.

It's under test now, I hope this removes all CAN hw overflow problems
that I observed.

