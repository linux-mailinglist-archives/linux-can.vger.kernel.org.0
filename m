Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85CD0BC5
	for <lists+linux-can@lfdr.de>; Wed,  9 Oct 2019 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfJIJuu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Oct 2019 05:50:50 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:34814 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJIJuu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Oct 2019 05:50:50 -0400
X-ASG-Debug-ID: 1570614647-0a7ff54e97bb4c20001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b01.edpnet.be with ESMTP id rRt64aUJN9MpT4C2 for <linux-can@vger.kernel.org>; Wed, 09 Oct 2019 11:50:47 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id A67A9A4C938
        for <linux-can@vger.kernel.org>; Wed,  9 Oct 2019 11:50:47 +0200 (CEST)
Date:   Wed, 9 Oct 2019 11:50:45 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: Re: [PATCH] c_can using rx-offload
Message-ID: <20191009095045.GF23530@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] c_can using rx-offload
Mail-Followup-To: linux-can@vger.kernel.org
References: <20191009074338.GA23530@x1.vandijck-laurijssen.be>
 <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570614647
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 106
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3430
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77241
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

@Marc,

The series is based on can-next/c_can, the version under test is rebased
on can-next/for-kurt
