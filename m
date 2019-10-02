Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC39C4939
	for <lists+linux-can@lfdr.de>; Wed,  2 Oct 2019 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJBIMo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Oct 2019 04:12:44 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:47526 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJBIMo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Oct 2019 04:12:44 -0400
X-ASG-Debug-ID: 1570003962-0a88186e234491190001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b03.edpnet.be with ESMTP id WHSmm6bosoWgwUrH for <linux-can@vger.kernel.org>; Wed, 02 Oct 2019 10:12:42 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 42D15A236BF
        for <linux-can@vger.kernel.org>; Wed,  2 Oct 2019 10:12:41 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: [RFC] make can-rx-offload easier to use, and use in c_can
Date:   Wed,  2 Oct 2019 10:12:33 +0200
X-ASG-Orig-Subj: [RFC] make can-rx-offload easier to use, and use in c_can
Message-Id: <1570003956-15727-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1570003962
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 726
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9990 1.0000 4.3308
X-Barracuda-Spam-Score: 4.33
X-Barracuda-Spam-Status: No, SCORE=4.33 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77027
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is what I build so far. It needs testing, but it seems I got all things
in place.
I extended the rx-offload so it can be used easier, ie. without
mailbox magic around. I needed this because the IRQ of c_can takes
an initial sample of filled mailboxes, and until those have been emptied,
no others are done. This requires a bit more context that is not
in rx-offload so far. Adding something there smells like over-engineering
the problem. The solution I took is to make advantage of rx-offload
as much as I need, and no more. The changes to the c_can driver remain
minimal now, so easier to test.
I created the patches on top of Jeroen Hofstee's work.
I will test this only tomorrow.

Kind regards,
Kurt

