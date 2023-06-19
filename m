Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42902735D99
	for <lists+linux-can@lfdr.de>; Mon, 19 Jun 2023 20:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFSSzj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Jun 2023 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFSSzi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Jun 2023 14:55:38 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6063D130
        for <linux-can@vger.kernel.org>; Mon, 19 Jun 2023 11:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687200934; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G/TuTY3YBIQIhTmD40SEWjXtzeZwAv5xQ+tVzdiO+tCONnqz2S7m2VanF7qPR3sCWV
    z2s2FEXV2oL9uTeEQ3sY3vLo1e50BbJ5ll9B05xoJmf0nfWrOPiOeyJsVS6GoJ8buS5n
    iURpGEcyqd5HfNNCmD0UFFO6H0LgrYEUv1QqYIurwMGuA1GiQ3ja1grv2v7+sTfb+a8I
    ugzXOO3p3s6BqU2WxGlLYfQO+sXVzrfGpoMHC4GQxNyLiO9UTEapgRjJWXF9wLx1ILTf
    NXdmF6xww7EAfiwx275wNfnif87SJlLvnFBfQV2Ur10iTUocXzlxfDNu8GQ4Mm9CywlW
    pFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687200934;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GGX1hB05MOoFQkE1vw4f1AddQhvNlPKnBBstJpmir+w=;
    b=c1CHSlLR9pNH+wKTTnjKxna7roeWBOmwg+6WfXdmk7hhtn1Kw8UFvAMmu71yd5d1M6
    Dg7a2U1LhsJ6HeX3EE7e1b7Bs1Y4PwGh6O1OZjp7mN3OZfQXqt8H6IqT1LrabGNmfPSX
    VLtkLgOIAldrcPO1IBcOHM89+dxmHrVskxdaLDd8dlamOmzIP9vI8wHk4nPFSVh+4jHj
    54/x8qqc3EP9EZRlSdonRsHv5viQbBC9WbJASNILapolwfXJ5URmUlDwDaCQyuIS0a9K
    QjqWWA1/dEfx1JUC6e3unAYXecDEippbXUGi71wAg/FpCEH+QIXgmZr4Zo+fmeY3IOPy
    3sTQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687200934;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GGX1hB05MOoFQkE1vw4f1AddQhvNlPKnBBstJpmir+w=;
    b=B2se2gQxxDWR9ZmEB5RDO4EmKtlpBReSM71h4JJ2ER5nQKBlnMvtjQrnGQhDd8PR+T
    Y93Shojwyqzd51XufJRUwokmPgIdMJzrX9UGabRatHT1ulUCj6UDFEBqyQXCEnzAFlWZ
    Um7oZrQ6eTuiOqmXlXWV3ps3IhCFmmGrlquKrOkaf2RHHRsLgCHh0J1MMqFzs5LRKhOf
    hWQ7HdcW7XJVPDCQHRnERkJ4ehW0gsMxa0aXZ7Y8DR8KNz9BTuQpMNcjWkj+1SXMWNrz
    5+ih96ykVNhQJislNCeVyVcFmB0faA0Btq/k621eBAJJSw2lk7vzErfcVGnZWhV9b3h3
    6DDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687200934;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GGX1hB05MOoFQkE1vw4f1AddQhvNlPKnBBstJpmir+w=;
    b=YseppzoAhTbM8e+Worltmy8712upz+AwuSz4dgcLmjlpNX4wHvkjmSvB3WdBXfzKNy
    oAASEjKFWbV4cGw3jYAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id J16f43z5JItYE4Q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jun 2023 20:55:34 +0200 (CEST)
Message-ID: <c7472c24-9e16-7c2d-f5f6-a24b0fc5e5fa@hartkopp.net>
Date:   Mon, 19 Jun 2023 20:55:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] can: ti_hecc: fix coding style
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20230619131058.198769-1-mkl@pengutronix.de>
 <20230619131058.198769-3-mkl@pengutronix.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230619131058.198769-3-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 19.06.23 15:10, Marc Kleine-Budde wrote:
> This patch aligns code to match open parenthesis.
> 
> Fixes: eb38c2053b67 ("can: rx-offload: rename can_rx_offload_queue_sorted() -> can_rx_offload_queue_timestamp()")

Does it really make sense to add a "Fixes:" tag for editorial stuff?

Will this potentially trigger the stable guys?

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   drivers/net/can/ti_hecc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
> index 9bab0b4cc449..54284661992e 100644
> --- a/drivers/net/can/ti_hecc.c
> +++ b/drivers/net/can/ti_hecc.c
> @@ -625,7 +625,7 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
>   
>   		timestamp = hecc_read(priv, HECC_CANLNT);
>   		err = can_rx_offload_queue_timestamp(&priv->offload, skb,
> -						  timestamp);
> +						     timestamp);
>   		if (err)
>   			ndev->stats.rx_fifo_errors++;
>   	}
