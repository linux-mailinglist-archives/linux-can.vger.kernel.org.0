Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60004190B5
	for <lists+linux-can@lfdr.de>; Mon, 27 Sep 2021 10:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhI0I0q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 27 Sep 2021 04:26:46 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:32809 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233337AbhI0I0q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Sep 2021 04:26:46 -0400
Received: from MTA-05-3.privateemail.com (mta-05-1.privateemail.com [198.54.122.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 4411480C30
        for <linux-can@vger.kernel.org>; Mon, 27 Sep 2021 04:25:08 -0400 (EDT)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
        by mta-05.privateemail.com (Postfix) with ESMTP id 2E74918000B8;
        Mon, 27 Sep 2021 04:25:07 -0400 (EDT)
Received: from localhost (unknown [10.20.151.233])
        by mta-05.privateemail.com (Postfix) with ESMTPA id F195918000A1;
        Mon, 27 Sep 2021 04:25:06 -0400 (EDT)
Date:   Mon, 27 Sep 2021 01:25:06 -0700
From:   Matt Kline <matt@bitbashing.io>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH v3 2/3] can: m_can: Batch FIFO reads during CAN receive
Message-ID: <YVF/4iJDwLXTJOCJ@kline-desktop>
References: <20210817050853.14875-1-matt@bitbashing.io>
 <20210817050853.14875-3-matt@bitbashing.io>
 <aa0d3bed-dd0d-ae13-d0ef-6fb130db5aa5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa0d3bed-dd0d-ae13-d0ef-6fb130db5aa5@ti.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey Aswath,

Definitely looks like a silly mistake on my part, thanks for sending fixes!
Apologies for the slow response; I was out for the past week or so.

Best,
Matt

On Thu, Sep 16, 2021 at 05:34:45PM +0530, Aswath Govindraju wrote:
> Hi Matt, Marc,
> 
> While reading multiple register fields and calling iomap_read_fifo() in
> m_can_platform.c is causing an issue.
> 
> In iomap_read_fifo(), ioread32_rep() is being used for reading.
> ioread32_rep reads() from the same source address for val_count times.
> This is not the intended behavior here. The source address also needs to
> be shifted along with the destination address.
> 
> Is a fix required in iomap_read_fifo() ?
> 
> Thanks,
> Aswath
