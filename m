Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3918A6D6191
	for <lists+linux-can@lfdr.de>; Tue,  4 Apr 2023 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjDDMtk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Apr 2023 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjDDMtj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Apr 2023 08:49:39 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC3C10D0
        for <linux-can@vger.kernel.org>; Tue,  4 Apr 2023 05:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680612507; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pgpvbgpC5HmDxhnBaonrJHbdYOCPTyge5HukN6ocDH6lx9C6oTeiM+XHSaoQCO9brE
    +TvJ82s8KavYKS4EsZqENFiIJeqRnLWxgLtndEQtsDdj6s8HA9tCMZPITkdyN6Gcz4db
    EUBwJlwvi8sM4Hls+++9wbZznrRZKNg7R4Mv6ywrvJtiCq1j/hVLYQhYcD1rsRvwE9dZ
    UfasyoHin0wWRBZZ3v4qvnkMpBWWvDxyFWQdGrEJcDBCZmroTvvBS48vtrzikgPz8MJp
    xKJWH3ng4Y4rHXWArzm6h6gGvBHcXBVh1Z3FHqZMGmLB2bQAFpcc/II98fQROx2W4D6e
    eeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680612507;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7RHsnl8qNBRuH53cdOTOuUjDWdA/xmTmAVKM3QNtoNk=;
    b=b4SisY99eUqQSGLGZ6yE7iA9RZnCbZfTLnAKKd0Ea6gym9CNhUEzCQJeIO6rDk/ptJ
    195ZdFpMMnWDXR0KOLCnKzfD2rtYb+S9SutZfJxDs1EjUl7UKa5PutFZZEiKkRAK8s9u
    W5dnWHDXdBEVqatauP8SJVerWhZ6VlWFXVd3+O3/VcSSMLqN8TbALlz6leThD2yu8p5v
    sdSfNw6CFzTphmr4ND0GHECbrf2ZMAILFEJnFf4YwyRyKGRcwA4/S0ea2RI4yVCiU9QE
    lB49qfAEYE2/LaxK02Ge1TF2omrwsDhkWJqkk1g5Ut//GmxbEhvy85Mc4q2csC2r3G7Q
    UQzA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680612507;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7RHsnl8qNBRuH53cdOTOuUjDWdA/xmTmAVKM3QNtoNk=;
    b=f9mtJlOtRUeu690zAlrknYyfoffviybHabSn0Z+HjSD11yu4DikTZuyw4PtEYiUIOs
    ODaH6zCVOCQjMyppkdrTLuWA3QxGzzhlMJtcO6fHG34hIeThuKmHtswiBJQGC1f3ZFZ4
    lPIlALp14uUegqepytzJyjcnS0fvND0I0uWEFb4ija3cQeh+OQ3AM3Zw52hfkwvKgRe4
    QXj3MhDwIxWb9L8gXKfuK1FTxaYh9UN4cXYrW3bQwEBxbKnm7HnyCRlMgLBcc+wa9/hW
    vlrlPURz0fjyXSN7UdbGdKwY1i/vQB6CG3Ot0XC5EzGMZ0v1D2MbU7F9QB3ReFEqoOyP
    51xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680612507;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7RHsnl8qNBRuH53cdOTOuUjDWdA/xmTmAVKM3QNtoNk=;
    b=qabrAcRMovbWkizuwywaTQrSKppYtLWKs1cOM1iDYgsYXMP1PYumqNqWgKgKU999Y+
    xmZS+HjoersSzflWM0Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x06214z34CmR2qi
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 4 Apr 2023 14:48:27 +0200 (CEST)
Message-ID: <6297bfba-7aa5-2036-9a48-1f9c386a36fd@hartkopp.net>
Date:   Tue, 4 Apr 2023 14:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v4] can: isotp: fix race between isotp_sendsmg() and
 isotp_release()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, "Dae R . Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
References: <20230331131935.21465-1-socketcan@hartkopp.net>
 <20230404-devotion-gerbil-59dd8418d4ba@pengutronix.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230404-devotion-gerbil-59dd8418d4ba@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 04.04.23 08:09, Marc Kleine-Budde wrote:
> On 31.03.2023 15:19:35, Oliver Hartkopp wrote:
>> As discussed with Dae R. Jeong and Hillf Danton here [1] the sendmsg()
>> function in isotp.c might get into a race condition when restoring the
>> former tx.state from the old_state. This patch removes the old_state
>> concept and implements a proper locking for ISOTP_IDLE transitions in
>> isotp_sendmsg() inspired by a simplification idea from Hillf Danton.
>> Additionally a new tx.state ISOTP_SHUTDOWN has been introduced to use
>> the same locking mechanism from isotp_release() which resolves a
>> potential race between isotp_sendsmg() and isotp_release().
>>
>> [1] https://lore.kernel.org/linux-can/ZB%2F93xJxq%2FBUqAgG@dragonet/
>>
>> Cc: Dae R. Jeong <threeearcat@gmail.com>
>> Cc: Hillf Danton <hdanton@sina.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Can you add a fixes tag?

Yes.

Fixes: 4f027cba8216 ("can: isotp: split tx timer into transmission and 
timeout")

Many thanks,
Oliver
