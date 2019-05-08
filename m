Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F1D17D4E
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfEHP1v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 8 May 2019 11:27:51 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36134
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfEHP1v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 11:27:51 -0400
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764414; Wed, 08 May 2019 15:27:48 +0000
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/6] can: mcp25xxfd: fix sparse warnings and typos
From:   kernel@martin.sperl.org
In-Reply-To: <20190508134420.29982-1-mkl@pengutronix.de>
Date:   Wed, 8 May 2019 17:27:59 +0200
Cc:     linux-can@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <82D0B719-F2DC-4DA2-8764-3B8EEF42992D@martin.sperl.org>
References: <20190508134420.29982-1-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: Apple Mail (2.3124)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc!

First of all: thanks for all the feedback!

> On 08.05.2019, at 15:44, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> while integrating the patches sparse complained about several things.
> I've fixed most of them with these patches. Feel free to squash then.
> 

As I am working on V8 already I shall incorporate all your feedback
into the new patchset if that is OK with you.

> Can you please fix the following warning, too:
> 
> | cp25xxfd_can_rx.c:162:18: warning: cast to restricted __le32                                                                                     
> | cp25xxfd_can_rx.c:163:21: warning: cast to restricted __le32                                                                                     
> | cp25xxfd_can_rx.c:164:18: warning: cast to restricted __le32 
> 
> You get these, if you compile the kernel with the option "C=1". You need to
> have "sparse" installed for this.

I shall be using that in the future - thanks for the pointer.

Martin
