Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C45C48E952
	for <lists+linux-can@lfdr.de>; Fri, 14 Jan 2022 12:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiANLmG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 14 Jan 2022 06:42:06 -0500
Received: from projects.drlauer-research.com ([88.99.0.140]:56214 "EHLO
        projects.drlauer-research.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232850AbiANLmG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Jan 2022 06:42:06 -0500
Received: from smtpclient.apple (b2b-109-90-164-198.unitymedia.biz [109.90.164.198])
        by projects.drlauer-research.com (Postfix) with ESMTPSA id 059434801D1;
        Fri, 14 Jan 2022 12:42:01 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: Filter on controller level
From:   "Dr. Michael Lauer" <mickey@vanille.de>
In-Reply-To: <0761fe12-69bc-19db-951e-61e06d93d03e@hartkopp.net>
Date:   Fri, 14 Jan 2022 12:42:01 +0100
Cc:     linux-can@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6B05F8DE-7FF3-4065-9828-530BB9C91D1B@vanille.de>
References: <59415BCF-B758-410C-8007-3E6CA446ACA4@vanille.de>
 <0761fe12-69bc-19db-951e-61e06d93d03e@hartkopp.net>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        projects.drlauer-research.com
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

> Am 07.01.2022 um 13:15 schrieb Oliver Hartkopp <socketcan@hartkopp.net>:
> 
> Hi Michael,
> 
> On 07.01.22 10:50, Dr. Michael Lauer wrote:
>> Forgive me, if that’s a topic that already came up…
>> …reading the recent patch sets where hardware CAN capabilities are exposed to userland,
>> I wonder why we still don’t have standardized ioctls (or whatever other means) to
>> control the hardware arbitration masks that seem to be present in almost all CAN controllers.
>> In particular, I’ve stumbled over the https://github.com/craigpeacock/mcp251x, which is a driver
>> that exposes the hardware filtering at module load time. Wouldn’t it be helpful to
>> have a standardized way to control this? Also the isotp could make use of this.
> 
> In fact we started discussing about a common interface to configure CAN hardware filters in 2018:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=can-hw-filter
> 
> But it didn't get further - probably because nobody really pushed this feature.
> 
> I have to take a look on that discussions around 2018-02-20 ...
> 
> https://lore.kernel.org/linux-can/98bcd448-4d2a-bf2f-ae5a-4db7f1eac896@pobox.com/
> 
> There were some patches flying around too:
> 
> https://marc.info/?l=linux-can&m=151949929522529
> 
> https://marc.info/?l=linux-can&m=151949942422563&w=2
> 
> But these patches are not available in https://lore.kernel.org/linux-can ¯\_(ツ)_/¯

Interesting. That all looks like we’re almost there! What can we do to get the momentum
going again?

The reason why I’d really love to see this is that we have those tiny Linux-capable
SOCs these days which – albeit really powerful compared to a microcontroller – are
still kind of challenged when it comes to serving CAN under load. On systems like
the Raspberry PI Zero (2), every unnecessary context switch hurts ;-)

Best,

Michael Lauer.


