Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33801303622
	for <lists+linux-can@lfdr.de>; Tue, 26 Jan 2021 07:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbhAZGBZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jan 2021 01:01:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:37042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbhAYO3n (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 25 Jan 2021 09:29:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA4E9B9B9;
        Mon, 25 Jan 2021 14:28:54 +0000 (UTC)
Date:   Mon, 25 Jan 2021 15:30:00 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     ltp@lists.linux.it, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Subject: Re: [LTP] [PATCH v3 7/7] can: Update contact details
Message-ID: <YA7V6FNZGGma+HiI@yuki.lan>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-8-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120143723.26483-8-rpalethorpe@suse.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!
Minus the runtest files that has to be updated the rest looks ok.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Also I do wonder how much of can functionality these tests does not cover.

I guess that we can as well write a test that would add two or more
virtual devices setup routing and send messages between these.

Also there seems to be several different protocols and we seem to be
using only CAN_RAW.

There seems to be also flag to inverse the filter mask with
CAN_INV_FILTER, filter only for error messages and so on.

-- 
Cyril Hrubis
chrubis@suse.cz
