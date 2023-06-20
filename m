Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8417363B4
	for <lists+linux-can@lfdr.de>; Tue, 20 Jun 2023 08:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjFTGld (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Jun 2023 02:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjFTGlc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Jun 2023 02:41:32 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5B910FB
        for <linux-can@vger.kernel.org>; Mon, 19 Jun 2023 23:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687243288; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CLWgLTiYPNrinNGcYOU3HxnJzdF0+fESUW3+6/04n3G7cDw9nGR4rQIyi0kiwMOpbo
    5DUXJjUpolO9mPTcjXw+YAxdmAewODeSKUGHDX8AxMVn1hHcIaRZBOBsK/ppWjROc8Om
    XHJagltodovjxkZLrGQi8cG6BGuIQfeIi1p7XHNBJS52M7fhNejEEgsfZK6KTigsfhR5
    6UaoOPsV2L+MCmRRKI5rnTPOO0zRDSlCgNv0SNe/zLbVgWyeEKZE/nbuK1flz3yvEFT0
    nHJSr/423bCrgLQSBF9nVO/OXJqsc9MRw/fAAXSl7jopb1Rn1qaFoJs9NW3/EwVNhDZb
    Ro+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687243288;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4KVbMjaeKgsAbEm1IYXnezOslqbpwuz2exuFCascbWE=;
    b=P3Qn0tFzjidu2a/VZfwE5+CqgVf40IXXUWpq5HQMPf8Bc8Pr1l0Bp/q2d4N2aIVcSv
    Ho3/PhF3freakBJDky1StxdOS2EFvukLK8/Rkr24EyAQOaHHyG/lZp/Xrq87j+mc3gE5
    tpr2IA5WpAo65E0vdckuidf+eDNRCl6O9qZCS+II/uuRou05JPtD/GwO1ZPL/yYe+d/0
    PGTnN4u3GGw18z1MajPHRyZXK6KCQmh2Q5GtvJ8dFQnR68lsIsjmXHsySSOfVN1kgTNo
    s9GrVUPZR2N6yJC+DfNBHxP4C/LSlaqRbkVCJSocMHcptFRqFpNM1bytP5ulCzvUKF33
    4hNw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687243288;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4KVbMjaeKgsAbEm1IYXnezOslqbpwuz2exuFCascbWE=;
    b=eJ3EZISLHjz6AWD29pq87/o00L4+AniDWt/VALV0QTFY4POFlhduehkotPFnV9D1nj
    /2vVU0qSNCDaMTQbh8F8m+HsVJKxTs+AO/AsZ/nPabcnHrg6wsjqi4Tt0hbfr1D7Yi65
    pJGLqzD6ofZdrCqloGaq8FzRg9Io07NpG22Tby07deiFh12EUtXywDWFgMQb+xJBB5OP
    f4pH4mVLarYzdAz2xKvOvL7Jz0UcruUPvPAFEmwpPDMvMeGc+7UoUePTu9pxdA5Vcmse
    5XzSaowRUg0JSps2ehRueuURBRUEQYE0Yprj2gp0wGtIDmCXPzE/iqkHy+7LwyfAT2p9
    Ch1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687243288;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4KVbMjaeKgsAbEm1IYXnezOslqbpwuz2exuFCascbWE=;
    b=AaM5deuiDehTQwJ96kylWgn7FS1d1KQmDbg/kRmVR80t93rBCoVZVtL89vdyiMY1sO
    GnrWEKqzJ4p87e7ftBAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id J16f43z5K6fSElj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 20 Jun 2023 08:41:28 +0200 (CEST)
Message-ID: <f79bd6da-d85b-9d01-ba66-41f9c9f6e6d5@hartkopp.net>
Date:   Tue, 20 Jun 2023 08:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] can: ti_hecc: fix coding style
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
References: <20230619131058.198769-1-mkl@pengutronix.de>
 <20230619131058.198769-3-mkl@pengutronix.de>
 <c7472c24-9e16-7c2d-f5f6-a24b0fc5e5fa@hartkopp.net>
 <20230620-spoiler-willfully-fe2954517979-mkl@pengutronix.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230620-spoiler-willfully-fe2954517979-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 20.06.23 08:31, Marc Kleine-Budde wrote:
> On 19.06.2023 20:55:28, Oliver Hartkopp wrote:
>>
>>
>> On 19.06.23 15:10, Marc Kleine-Budde wrote:
>>> This patch aligns code to match open parenthesis.
>>>
>>> Fixes: eb38c2053b67 ("can: rx-offload: rename can_rx_offload_queue_sorted() -> can_rx_offload_queue_timestamp()")
>>
>> Does it really make sense to add a "Fixes:" tag for editorial stuff?
> 
> Yes, why not. I like keeping track if things. Also the
> process/maintainer-netdev.rst says:
> 
> | - for fixes the ``Fixes:`` tag is required, regardless of the tree

I do not think that whitespace changes can be categorized as "fixes" as 
they do not fix any functionality.

IMO this is not the intention of that sentence.

Best,
Oliver

> 
>> Will this potentially trigger the stable guys?
> 
> If it does, it should be a big warning that they take too many patches.
> 
> Marc
> 
