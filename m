Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF3784A7A
	for <lists+linux-can@lfdr.de>; Tue, 22 Aug 2023 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjHVTaj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Aug 2023 15:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjHVTai (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Aug 2023 15:30:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7764D1BE
        for <linux-can@vger.kernel.org>; Tue, 22 Aug 2023 12:30:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99cdb0fd093so662380366b.1
        for <linux-can@vger.kernel.org>; Tue, 22 Aug 2023 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692732635; x=1693337435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiTP/RI45e8EfwrIe7RLSXEmq0rHur4HBZ7nN4+v1xg=;
        b=wZXMbA3VCSIlp2ExjJhWXkxhybOC2Jr5EiO3B9BIUuNMsTlnPTBEH1wJHmBHDLnWsY
         LdZhdmojjosNGKBWCHMEOO+8OuiTJjsA7kTFImNog2ZbH6AO2lai1WutJlraP4nfQnUb
         Z1ni5xIXI3yovMjhlzNSfnGRkufwraSLhB6VMrlt9NgGq8wfbZwNdsHqRtmWeBJauTLO
         GvypdQwJKg22HVxjnrc57/oXt4eLfGCis2HfV2g56dXRfDx7Buzf32Ukk+5dFmKarqcE
         sD++faPaO8DDr5qQ1u678wHSkGkWDhVVXZPyfsYNOLz9feoqn/jfo/hrqeCsbHB91GLE
         KRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732635; x=1693337435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiTP/RI45e8EfwrIe7RLSXEmq0rHur4HBZ7nN4+v1xg=;
        b=VC+UCPeS8Om7bwVPesMzMifeslZTfNpxe3Rkjl2H63hvhc8KDQOespC7kFKaR3MD50
         WCga+aGIEdv0uwCIfCsKW0+4BgPGz/0iLHa/TzsQ3kOYJtLgzLeN2qECz0hIHva+67Zj
         MQcSsCGNqcYs7fy5nLxhEcOVzaOqpvZwMRqiFRdDcxfimFR7hyq5O0FdGXofblA+eh3X
         pgBhvoZJ9PK0m4R986F5MSluXsVOBfE/BGzapOFhAfxzVMtWkAnMp1GjUf3ek1opatnn
         rf3VzEXeIrqpgm41zydnFEUqjxKmSJXPkHoqFzzqBHwe8XgYEk/XrZIoV0q2a3ZkNz+5
         A6xg==
X-Gm-Message-State: AOJu0Yx7foaOyl8Rl6pVKo+KNdwFETqY+qprWpdqV78ckDR1okPW7CM0
        /SzoDCyspB9EFsBMP0AXbMsjeQ==
X-Google-Smtp-Source: AGHT+IHQnILBTb+i3Z2VnWNYiVEYRv6UUWWJMV9wl3Fp1TSArLq989ixRcaCrMjL0ry+Q8cXL5X3Lg==
X-Received: by 2002:a17:907:763b:b0:99c:ca27:c44c with SMTP id jy27-20020a170907763b00b0099cca27c44cmr7868302ejc.45.1692732634835;
        Tue, 22 Aug 2023 12:30:34 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id sa17-20020a170906edb100b00997d76981e0sm8626693ejb.208.2023.08.22.12.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:30:34 -0700 (PDT)
Message-ID: <fff772d3-a5c7-77c1-c372-22b2313ee622@linaro.org>
Date:   Tue, 22 Aug 2023 21:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_1/3=5d_dt-bindings=3a_can=3a_xilinx=5fc?=
 =?UTF-8?B?YW46IEFkZCBFQ0MgcHJvcGVydHkg4oCYeGxueCxoYXMtZWNj4oCZ?=
To:     Srinivas Goud <srinivas.goud@amd.com>, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de
Cc:     git@amd.com, michal.simek@amd.com, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gcnu.goud@gmail.com
References: <1692701136-1422086-1-git-send-email-srinivas.goud@amd.com>
 <1692701136-1422086-2-git-send-email-srinivas.goud@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1692701136-1422086-2-git-send-email-srinivas.goud@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 22/08/2023 12:45, Srinivas Goud wrote:
> ECC feature added to Tx and Rx FIFO’s for Xilinx CAN Controller.
> Part of this feature configuration and counter registers added in
> IP for 1bit/2bit ECC errors.
> 
> xlnx,has-ecc is optional property and added to Xilinx CAN Controller
> node if ECC block enabled in the HW
> 

Second time the same mistake... and I spoke about this mistake twice:

1.
https://lore.kernel.org/all/78b104cd-15a2-63d8-bbce-0a5593e6a151@kernel.org/

2.
https://lore.kernel.org/all/aed1592f-927f-13ab-b692-7a0745ac5733@kernel.org/

I don't understand why this is so difficult... automation solves all the
problems, there is no manual work here. :/

Anyway, standard text:

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

