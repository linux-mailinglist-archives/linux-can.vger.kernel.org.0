Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D812FBE35
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 18:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbhASRr7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 12:47:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:39986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731893AbhASPGG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 19 Jan 2021 10:06:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 370AEB737;
        Tue, 19 Jan 2021 15:04:59 +0000 (UTC)
Date:   Tue, 19 Jan 2021 16:06:02 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Subject: Re: [LTP] [PATCH v2 4/6] can_recv_own_msgs: Convert to new library
Message-ID: <YAb1Wncn2/x6LBYj@yuki.lan>
References: <20210119093143.17222-1-rpalethorpe@suse.com>
 <20210119093143.17222-5-rpalethorpe@suse.com>
 <322f1056-0a73-65e6-531a-3275029df256@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322f1056-0a73-65e6-531a-3275029df256@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!
> >  /*
> > - * tst-rcv-own-msgs.c
> > - *
> > - * Copyright (c) 2010 Volkswagen Group Electronic Research
> > - * All rights reserved.
> > - *
> > - * Redistribution and use in source and binary forms, with or without
> > - * modification, are permitted provided that the following conditions
> > - * are met:
> > - * 1. Redistributions of source code must retain the above copyright
> > - *    notice, this list of conditions and the following disclaimer.
> > - * 2. Redistributions in binary form must reproduce the above copyright
> > - *    notice, this list of conditions and the following disclaimer in the
> > - *    documentation and/or other materials provided with the distribution.
> > - * 3. Neither the name of Volkswagen nor the names of its contributors
> > - *    may be used to endorse or promote products derived from this software
> > - *    without specific prior written permission.
> 
> IANAL, I think you're missing this license. Is looks like some sort of BSD to me.
> 
> > - *
> > - * Alternatively, provided that this notice is retained in full, this
> > - * software may be distributed under the terms of the GNU General
> > - * Public License ("GPL") version 2, in which case the provisions of the
> > - * GPL apply INSTEAD OF those given above.
> 
> It doesn't say "or later".

Looks like we cannot just remove this license. So what about moving this
text into a separate COPYING file and changing the SPDX to GPL-v2.0?

-- 
Cyril Hrubis
chrubis@suse.cz
