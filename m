Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9557710AB
	for <lists+linux-can@lfdr.de>; Sat,  5 Aug 2023 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjHEQzj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 5 Aug 2023 12:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjHEQzi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 5 Aug 2023 12:55:38 -0400
Received: from out-95.mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761134207
        for <linux-can@vger.kernel.org>; Sat,  5 Aug 2023 09:55:36 -0700 (PDT)
Date:   Sun, 6 Aug 2023 02:51:53 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691254534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYiFCAoB7u7dk9JF+5uYfQo9xx6aksS21sN43dAesb0=;
        b=JrgfMyBOF+ZiXCAmC60LBYPR24oFRCx33u0KZKY303F1zTsxaeJJ7iEE6sA7OWwJCUtxVw
        A4UvLxWn95TKqI4CkmGVAhWOqcAk4CvjbA6aGNLXTBYeY5prTGoIAKBqUNZfh8PsTWAhSx
        mkMIlM80OTxepI54dfk4DvO/fhfio2g2w6Zzi5o65Zgb64BkrnRxk/0vcwiQ5WIdKQu7ws
        UkUlMgbKObQ9hReGcP3QkIQBOowRV6faBzQyCP3EDy5F73PN6SkeTDX0F52E6eStUZpU+6
        lQWwk6FI39d1N9Wuz7kOXLbqbOsByN6rNvid4pDiwRHmDYcOJf+RggI/enu0Ew==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     aou@eecs.berkeley.edu, conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
        mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        samuel@sholland.org, wens@csie.org, wg@grandegger.com
Subject: Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller
 nodes
Message-ID: <ZM5-Ke-59o0R5AtY@titan>
References: <20230721221552.1973203-4-contact@jookia.org>
 <20230805164052.669184-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805164052.669184-1-bigunclemax@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, Aug 05, 2023 at 07:40:52PM +0300, Maksim Kiselev wrote:
> Hi John, Jernej
> Should we also keep a pinctrl nodes itself in alphabetical order?
> I mean placing a CAN nodes before `clk_pg11_pin` node?
> Looks like the other nodes sorted in this way...

Good catch. Now that you mention it, the device tree nodes are sorted
by memory order too! These should be after i2c3.

It looks like I might need to do a patch to re-order those too.

> Cheers,
> Maksim

John.
