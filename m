Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8F755E7D
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 10:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjGQIbD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 04:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjGQIbB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 04:31:01 -0400
Received: from out-26.mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2BB19C
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 01:30:58 -0700 (PDT)
Date:   Mon, 17 Jul 2023 18:28:16 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689582657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QJ9/CuAa6+LDouLcF91K8imsDM9eYpGUVmE6W2rOKk=;
        b=CoVglM/4wL1Z5nL8yMaZJ7znRMpZp0juZsyvKM1r9iXeox57COEWWEsPGVu2/0Q8+zngEG
        EQc/q/RmbmK88P/6Nh3nT7aR+v+b/pzh07rvYJLxP/btmPrScrmmSbndZ47MFNJxfCkBZt
        TJddnOThZI8a9Nz21hPzJqNmEjekLZrHfgFRhlIXasMeqn2tzTe1lTpxjvLIh1EX7C5KtW
        EsbcVgEVgzPooo/++nqSAsgX04TEIMLc83lGZ8JhTqI26z86IB2V+XD7IzH3hbdKmpLNPd
        r/hjcbuS8f4/M115X7hwukpAbTWAusuOyZJCA6T4TkrZhhFrNYWC3uKT+WERJw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 3/4] can: sun4i_can: Add send support for the Allwinner D1
Message-ID: <ZLT7oPwl1O2TXpxw@titan>
References: <20230715112523.2533742-1-contact@jookia.org>
 <20230715112523.2533742-4-contact@jookia.org>
 <f3b1240a-4be0-4c02-0a63-561499ad6d0d@kernel.org>
 <ZLQgQAigmhk9uYYd@titan>
 <eb2d6e5a-595f-85f2-fe36-8acbb76d3987@kernel.org>
 <20230717-aluminum-driven-a008473620ca-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717-aluminum-driven-a008473620ca-mkl@pengutronix.de>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jul 17, 2023 at 09:03:06AM +0200, Marc Kleine-Budde wrote:
> Jookia, please let the patches build on each other so that the resulting
> kernel is consistent. The kernel at the state 3/4 will build and load
> the driver on the D1, but it will not work, as the new quirk is missing.
> Please exchange patches 3/4 and 4/4 (add the sun4ican_quirks_d1 in patch
> 4/4 only).

Shall do, thank you.

> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

John.
