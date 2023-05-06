Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113776F93AF
	for <lists+linux-can@lfdr.de>; Sat,  6 May 2023 20:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjEFStG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 6 May 2023 14:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjEFStG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 May 2023 14:49:06 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DD813869
        for <linux-can@vger.kernel.org>; Sat,  6 May 2023 11:49:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683398943; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VVzZuIbb7NKe2sYibTwbnTMy0duq9C8QJxU/oYn+j/P3TAS+4+zvn5bhMlGhI/qwI1
    LrVkQnKd353FqdqqWzwJBu4nEhh3WNw0HqP4qXweGOdDSGupdNvY7LabjR/t7NHioUTs
    2eAT9+ALz4H8nSgPVxYJ/bpBx6DfUFZx6HyHhEWjOZ0oJ0zVc20ZcQAM+roQ4yvCJx9+
    m65V5istu5+HATB6A6gk7OPITZZzc/mV+y2Hha2l82KddiLaJM5FM4Uxn3NcR/uVvtuf
    LScKFAskaWNr7YfnasS+w2W/SIbfbzopSRp/fP3kOi4RMnT+w/1jRpPm73JwRIsRBaO9
    WoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683398943;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=505w35/9UTfHPswJXIfNLWQPPyatIh5uKUZHPeeNl4E=;
    b=XHE05t5B+zoYhbZYu6ngHCDMiuNpvg75jaqYo0YtYAvwDd5srWV8vjRMMAYdaARRHK
    4d0nTLELCxmulf0W9AFFJhkKH6z2ukMKKnkl785CLbQtNL9vZGs84Djrpv+Qq4yb3BCD
    FJwqYQwM5GExNAdU68H4dpGocRmjlYNZ1G4NBnx6R03kWAj8GRntEtnl79HZG6q1iNqi
    KLDrmuvViRKnD8eTiYIHDS2fIuYcPM0ka99/hiPnUy0j4xSnJNaEip1EUbDqoS7hs3qy
    e1evX67S5TqldZ9u2GeNxX1tSQoZLSO4L4GQqnFkXqCHpK4uBKUSwmSBldOblp553lno
    2R6Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683398943;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=505w35/9UTfHPswJXIfNLWQPPyatIh5uKUZHPeeNl4E=;
    b=dXQ4kip5WlSgt8mS5wtXaj3zS9RSAdkH9e4vNJ7iUjnTBFYcHEMtskVUkUOI4IOHa3
    b17ZbI5zT5rW9pM/f6Uer2eoFhHKkdXVErCapZN5zXHmQ9EXqEGPKcqnrm2L9coCvOrR
    H2L/qZSUSm+/pGbdnDxiisqlej285jFerDjr+7u6dWzvqpKmnUYopI/tiL2SPl8fwWQd
    u1zVrh1AzrDfj8+neUnnfoSu75shypTyR0zO+uVfg6TqW2FERWSSal2E462MSwnJ5cnF
    7N4DPkApsu9cv1U0vFkc+gyeppo7iehBE0iPfOTvh6Hf5DmToLKPuSFPOuKkEAg5dssk
    j2hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683398943;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=505w35/9UTfHPswJXIfNLWQPPyatIh5uKUZHPeeNl4E=;
    b=OTlntFLjdAse3kOG8vQTZ980COp1i8VCTogcHdWAb3EvQv+VdUgqAr+DAANoo+90gq
    r2qhOZw8AyvA9ZD4riAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x06214z46In2Kj1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 6 May 2023 20:49:02 +0200 (CEST)
Message-ID: <fcc63052-dde9-ed01-f193-ed2f878a6103@hartkopp.net>
Date:   Sat, 6 May 2023 20:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/2] can: isotp: recvmsg(): allow MSG_CMSG_COMPAT flag
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     kernel@pengutronix.de
References: <20230505110308.81087-1-mkl@pengutronix.de>
 <20230505-dwindling-hut-a6ee800036ea-mkl@pengutronix.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230505-dwindling-hut-a6ee800036ea-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks Marc and Oleksij!

On 05.05.23 13:05, Marc Kleine-Budde wrote:
> On 05.05.2023 13:03:06, Marc Kleine-Budde wrote:
>> sending v3 of Oliver's original patch
>> (https://lore.kernel.org/all/20230406110845.5180-1-socketcan@hartkopp.net/).
>>
>> No code change since v2, but resending with standard git Message-Id
>> headers. I wasn't satisfied with my headers experiment. Sorry for the
>> noise.
> 
> I've also added stable on Cc while applying the series.
> 
> Marc
> 
