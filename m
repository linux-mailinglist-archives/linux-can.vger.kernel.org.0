Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81DE36D6C3
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhD1LtB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 07:49:01 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:14301 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhD1LtB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 07:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619610489; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oxko0Dfq5hICxQDYx3TU46nxjXRIxcGbed83IbrU3NemFINLca+z1L00KNtJUVei0v
    XBMid3bhY3oh2ad3Mbt+9ZDzlNoPfcNayfJw+um3l+gY4RPvLSfUgietk69XP5xJ9h/L
    H8g9Y6ki3YtxQ9TGUkNL6amH2Nw7r3IZIqktvuxvlPwqNRbeNTAyDl/R8FUbozd76vYY
    xqlbN2ofEVeVAz1dtKAALwYp6zSERKOVO/kVn1A8cIfZGGZp7vaUoEayIiE+RqJhqoAU
    NbOhr3y9KEC3ZYZBXT1VzFozEd9nray0JjmK1O8jM2vR3No+95k8ddlUNgVuLiyOxVwm
    rt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1619610489;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=mUixjQHBhf0pjkn50wp4eFMubXvV4tY4DX7zsoFTwEc=;
    b=m89ws3OgfVWt0z1FauNKhtErDa/GgIEs1C8YB41dA6DMw7rIPyORR+PDbl5qroRORp
    sAs0vqqCs2wsNe9gzLYgA4vmAYXlB7mc+Ms14lOW4/RbVWWWva5FrNkswcuUWl8q4oQI
    e/DJ0gUVYTO0VmiUXV+3Runphzc7ZqY1d+AjMGPR/tYT4BEUbzrKh5pjycsM9toLtzxl
    6bRT/jopa3skl90CWtmiVNo9A1ksADQQVmapQrtHVX0asqxJu84G2DQAmjvkjd8ngBlj
    LTqqJ3AoxXz67kf4E0dxuE40OayuONlTldT5acI/5NHwymwm5gWX9PHlIfIFLLJtamyE
    7pBw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1619610489;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=mUixjQHBhf0pjkn50wp4eFMubXvV4tY4DX7zsoFTwEc=;
    b=TWZ+NDk4HTC0xlZPnFLTJ2W/q3oNhheYNf8RH//nFJFvQ7MxHWVN8zKi9mgWMX/15Y
    xsuLXK81a9ApVNYzE0zRUBWxAiT732mmWkGOCCGYnqr7yNiqE0nR2Qk7OHvJdGu0jsGg
    fID4qDou1v7fn/WGsYdcBYwPozqGMClCvIaa3L5lga0OX7Mr6/aWNQFwQhSwIWcVG7gV
    jug9k3KoeYpjYBCQcAesZPBW1EG79yj2PEahNvHXOrU1fTMzQ1H/HBOapaA4RzV6gIsd
    xRsU2S3TeS3z9umLEQ1PY1KbMjmDldaFrqpL/9pPjsXPSt8RcMh+y9wh2fEHuALaEzPI
    T6Rw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.25.2 DYNA|AUTH)
    with ESMTPSA id f0a856x3SBm93hv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 28 Apr 2021 13:48:09 +0200 (CEST)
Subject: Re: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
To:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <7146dee416c049b5a29fd3cca8a1b773@liebherr.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <713316ac-2bde-3928-1c28-e7c6e23e9dc0@hartkopp.net>
Date:   Wed, 28 Apr 2021 13:48:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <7146dee416c049b5a29fd3cca8a1b773@liebherr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 28.04.21 13:43, Sottas Guillaume (LMB) wrote:
> Hello,
> 
> First of all thank you for your fast reply.
> 
>  From my point of view, I think it would make sense to return an error to the user when CAN_ISOTP_WAIT_TX_DONE option is set. Otherwise, I don't understand the use case of this option?
> If the CAN_ISOTP_WAIT_TX_DONE option is not set, then not receiving an error on timeout could be the expected behavior, as the user does not explicitly ask for completion.
> 
> Concerning the way of reporting the error, setting the errno would be a nice solution, as it would not require that much modifications. However, as Mark mentioned, the errno is not set.
> I'm not an expert in how this sk_error_report works internally, but I will try to get more infos about it.
> 
> In both cases, the documentation in the isotp.c (https://elixir.bootlin.com/linux/latest/source/net/can/isotp.c#L7) file is not correct, as it is not the actual behavior (most likely the expected).
> Additionally, I guess the -ETIMEOUT, -EILSEQ, -EBADMSG,... described in the same documentation are most likely not working that way either, but would be fixed if the errno is reported correctly.

Yep.

The sk_error reporting is obviously not the way to go.

See:
https://lore.kernel.org/linux-can/ee8058e0-af0a-8759-a62b-b1585c8992b3@hartkopp.net/

Best regards,
Oliver
