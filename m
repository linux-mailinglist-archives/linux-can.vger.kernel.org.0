Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8989E2B8F24
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 10:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgKSJiQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 04:38:16 -0500
Received: from muru.com ([72.249.23.125]:48722 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgKSJiP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 19 Nov 2020 04:38:15 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E5CC880C1;
        Thu, 19 Nov 2020 09:38:20 +0000 (UTC)
Date:   Thu, 19 Nov 2020 11:38:11 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        Faiz Abbas <faiz_abbas@ti.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: dra76x: m_can: fix order of clocks
Message-ID: <20201119093811.GJ26857@atomide.com>
References: <20201111141211.1577871-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111141211.1577871-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

* Marc Kleine-Budde <mkl@pengutronix.de> [201111 16:12]:
> According to the bosch,m_can.yaml bindings the first clock shall be the "hclk",
> while the second clock "cclk".
> 
> This patch fixes the order accordingly.

Thanks applying into fixes.

Tony
