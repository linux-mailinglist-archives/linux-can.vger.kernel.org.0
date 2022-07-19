Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8757A6DC
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 21:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiGSTAQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 15:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiGSS7y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 14:59:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8DF3AB3E
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 11:59:54 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u14so10496024lju.0
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ny1RWRXFxLBqypbWjVOzGExTtuzkdD1zbwIY3wovjXA=;
        b=NtdsnH/dF6V+yPuDeYZFQLCgWSgNjE5XXj8g/LvBJflshyEL3i5zPXQY4++YMjar6F
         zL03SwARlDY8Jc5vAX9OxSZuRVZ9ENaytqQMruEK+tylfPVfR4/SVJzr+A3M9olkJMFs
         KtCyvaMldJQTvUKhrax3QQwmjnckD0aDtchNwItP/Q+YgRIvTJdhlg0XTCc/MYMhb6AN
         hI4PP+OOOTiC6N03gycgVKKln4TRVXS2JizJtK9nu3gMq7HQM93RiOA+31ZfZtB4CUhv
         jRC/IADwRS8YpeYbv4VA9J/B3uuYm8Ul5/rgdJBODe1jD9a8ko0cnORhOg7OLaDYgJw0
         ikhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ny1RWRXFxLBqypbWjVOzGExTtuzkdD1zbwIY3wovjXA=;
        b=qv3PtLAyeKN0ePAgc8FT+rJ1RJ06/cTN4LIYJxsKxTie3Hx0epsTFoLsdQW9uN7D+7
         zmTBhGtPHCxol7YOtpIfF1DdnhxqNqNyMRnF9oUs5fBQ9D6Vr6xBSCzJXPQBvVgv3+Oa
         zp92kw3ZEkGg+ej6hLY6Or1WZqQUY2pqn4a/1oee51bflHpaMsYpxVcmTfIIpi6vLn7i
         kpWnv2qVWKUtKA7SuF0LC/lRiVOhqJuZHAfT1eW4WBFxBtUCUWl81i+Z2+GURpgUG7Ah
         mPvOuNbwNS5EcjNWIdNm96GkQoQhaQ1fzeKLhNYki0ytnMRxe16fKix77s/RtBIPVgUv
         F9ZA==
X-Gm-Message-State: AJIora+9QAKivSAubJqH8U466FtcY6vgqEKCIO3Xsq0X7XDiug1uaDD1
        7m9u6jEZ6BD5VapCeJfGjoR3rMxvRIUcLg==
X-Google-Smtp-Source: AGRyM1uxHgpWEYUikRfOVK7ifA878iFMN638gF088Ooyp5Fr6q8yIiySPZSh5KgdrG7cik6n7xXoyw==
X-Received: by 2002:a2e:9851:0:b0:25d:af45:8b01 with SMTP id e17-20020a2e9851000000b0025daf458b01mr7363869ljj.139.1658257192372;
        Tue, 19 Jul 2022 11:59:52 -0700 (PDT)
Received: from [192.168.16.196] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id j5-20020a056512344500b00489c6d55b86sm3347744lfr.34.2022.07.19.11.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:59:52 -0700 (PDT)
Message-ID: <48197e64-6dda-12d0-26ce-34054b23f7b4@kvaser.com>
Date:   Tue, 19 Jul 2022 20:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 00/15] can: kvaser_usb: Various fixes
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20220708115709.232815-1-extja@kvaser.com>
 <20220719184059.pzqgxsgl7hw3cdne@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20220719184059.pzqgxsgl7hw3cdne@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 7/19/22 20:40, Marc Kleine-Budde wrote:
> On 08.07.2022 13:56:54, Jimmy Assarsson wrote:
>> This patch series was originally posted by Anssi Hannula [1].
>> Since v1 I've rebased the patches on top of commit
>> b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")
>> and replaced a couple of patches with new ones.
> 
> Jimmy, as all of these patches went through your hands, they need your
> S-o-b. Can I add it while applying?

Sure!

> regards,
> Marc
