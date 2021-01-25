Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E55E303621
	for <lists+linux-can@lfdr.de>; Tue, 26 Jan 2021 07:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbhAZGBZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jan 2021 01:01:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:36274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbhAYO3n (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 25 Jan 2021 09:29:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57285AD24;
        Mon, 25 Jan 2021 14:28:29 +0000 (UTC)
Date:   Mon, 25 Jan 2021 15:29:35 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     ltp@lists.linux.it, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Subject: Re: [LTP] [PATCH v3 5/7] can_recv_own_msgs: Convert to new library
Message-ID: <YA7Vz6IanQ7fMgEQ@yuki.lan>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-6-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120143723.26483-6-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!
> -struct rxs test_sockets(int s, int t, canid_t can_id)
> +void test_sockets(canid_t can_id, int expect_rxs, int expect_rxt)

static?

However this is very minor.

-- 
Cyril Hrubis
chrubis@suse.cz
