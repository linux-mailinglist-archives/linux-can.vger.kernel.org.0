Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783F56D619F
	for <lists+linux-can@lfdr.de>; Tue,  4 Apr 2023 14:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjDDMwV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Apr 2023 08:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjDDMwU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Apr 2023 08:52:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A786EE0
        for <linux-can@vger.kernel.org>; Tue,  4 Apr 2023 05:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680612737; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CSuRmzQ5y9gqr54kdJLcOJbxVLnBM6Hh8ZMq+PBianyUqumovsYfqk4DXaRs+6IWoJ
    xLHOtgYh6HFXbyQKrnULzDqjLnBlq9HUrgjvQg56n7qaNL3BDxBW0Ra43AVZcPad95P+
    zJpuqtKp8JklVsL1ypuio2MtvUraRiL0WXdnOnkL4By1IrwL5oU6VygtpiyVDpXUFRHT
    ZLt8hCkSMWpPvfJHqpusvKoVj7SueD3N4WsDK1m/Sp59vGuKhnY1yhXaWygllcbJ4lMc
    5Nz0X0LUbmbAnQeeJsK2lm8W+xX7sqWN37tTRP1gd6irW0dkUtgWK/u9fVqiCyUJqrvX
    cfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680612737;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2UILpbERVh+B1/s0ceu+oZe1DBoR+f9A2QIQ49D5BUs=;
    b=PSDhBDm5ki20CG7I285VsKRQ31yhNYDAuSEuzHmfy5CLQZGeNknmDH+9WvlsldY7/H
    KiPn6MFrO5ErvZz3hGoGKsjsxrIrzftWmSY00oe/ihDIhLwoiYoSNDog6Eh0HFK84aOS
    3LAa2vUbnkVFPhQyvsD3sQyp1yWvGOYSzSsCfCdoDpmFGXAkFI0erYNfIEnA1mghnnez
    LPEwYqkot69OF4gzD8gHDdgZJ8p9s/hAajj9HwM4i04MOzQ99kqnVuAzFDT4GKDossAP
    IQp+XvA/nYAMVYzz78fDge6DIX6LqwFahdkQnA2x9/6PX44tPooxGBJXw5Z/sI+Eu3QF
    EjQw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680612737;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2UILpbERVh+B1/s0ceu+oZe1DBoR+f9A2QIQ49D5BUs=;
    b=XfPMHY3hirwvZBZTeg3CZHuRBF2z5M9oyYLgrzOpG7kqGqSlO19gtnTGv1OL74mcLL
    lYL9qvI+NwTtXBRup2C63qGMNT+h2wsvAN2Sywh+qoEONNxSJyLj7ERY2HMzzaP27/vA
    v21tHIfzp454wY1XcUP2ok2M1GvS3m+wlSiKIdQmwZcEIYwZYOtvI19xfciaYIY7zJSQ
    aFL6aGvzf5Q7Z0LK8Rfsa3K0wEg93DD0hsaxUrNBn8d7vflDoKNAN6ooTCPWlalcuhFt
    +ZSQhWiKcvrkEuJJvpKgkJx31JN518oPwhMF+Toex0+KBN86JZekBzBVfB93NVsXcV7Y
    l/BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680612737;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2UILpbERVh+B1/s0ceu+oZe1DBoR+f9A2QIQ49D5BUs=;
    b=vwMws0S+xLsxRY+5Qx9ZNbV7GsibpHzU7vVDdWv5V9Ru0vETuoX55Ct3DMfdWgNMzz
    rOfvX+3Clj/lhAA9vtAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x06214z34CqH2rk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 4 Apr 2023 14:52:17 +0200 (CEST)
Message-ID: <885c8ecf-ca5b-fef7-bdca-bc549f6bb3b2@hartkopp.net>
Date:   Tue, 4 Apr 2023 14:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] can: isotp: fix poll() to not report false EPOLLOUT
 events
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Michal Sojka <michal.sojka@cvut.cz>
Cc:     Jakub Jira <jirajak2@fel.cvut.cz>,
        linux-can <linux-can@vger.kernel.org>
References: <20230331125511.372783-1-michal.sojka@cvut.cz>
 <20230404-headstone-implicit-c101429f2b17@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230404-headstone-implicit-c101429f2b17@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 04.04.23 08:10, Marc Kleine-Budde wrote:
> On 31.03.2023 14:55:11, Michal Sojka wrote:
>> When using select/poll/epoll() with a non-blocking ISOTP socket to
>> wait for when non-blocking write is possible, false EPOLLOUT event is
>> sometimes returned. This can happen at least after sending a message
>> which must be split to multiple CAN frames.
>>
>> The reason is that isotp_sendmsg() returns -EAGAIN when tx.state is
>> not equal to ISOTP_IDLE and this behavior is not reflected in
>> datagram_poll(), which is used in isotp_ops.
>>
>> This is fixed by introducing ISOTP-specific poll function, which
>> suppresses the EPOLLOUT events in that case.
>>
>> Signed-off-by: Michal Sojka <michal.sojka@cvut.cz>
>> Reported-by: Jakub Jira <jirajak2@fel.cvut.cz>
>> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Can you add a fixes tag?
> 

The poll function was datagram_poll from the first day - so it never worked:

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")

Best regards,
Oliver
