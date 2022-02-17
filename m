Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9604BA002
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 13:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbiBQMWg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 07:22:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiBQMWf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 07:22:35 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C821CC287;
        Thu, 17 Feb 2022 04:22:21 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id h18so9291247edb.7;
        Thu, 17 Feb 2022 04:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fa4vEHL6S2KcD3G9SUdjwQICntm0LTJJKIpsYf4QZR8=;
        b=J1agxgKRWe2AMdnuQdwNjJwlOkWwB1/hEPJtX5giwEKJ5JPlQ3aj/BZXwGsNXn1de/
         JwOFugHGzXrzDB3u+vxrAYVoaDXYuGied0WB/XiZrq9+JgNnROjkQ/tBK0R4CBxk+CCP
         RJmKsWgLmHNzJ2V2xjF7ILY743+OoIYBmxwxjzG8MhLA/GQxsDcNIggN0p0ZsNbs+tIL
         nMsJKigtVMsUEIX3uFfwGb69QvnharUJbEYtFKs8UPi7ih4Pr2IkMCx80PB2Grv0dCCE
         c11Plgdf47T9QUxHfMuxtAiFQcRRLABxdlTDow1+J4QO9lQoTIDTkF5NhBBTEanrQzwN
         y+GQ==
X-Gm-Message-State: AOAM530VV7pIdC3zbCouwH6gzb08b819FhC8Tpss3iw2iJO+KMDzyUhM
        BCCF8lGilF7RiVsf7f0UY3I=
X-Google-Smtp-Source: ABdhPJzzgaercRG3g/iGQuk7IuNF/d9yiaTMYbYVRInoJ2lwupIaRv2HdDI0niZyW1hfU+yshW1tOw==
X-Received: by 2002:a05:6402:1d49:b0:412:8cf5:73fa with SMTP id dz9-20020a0564021d4900b004128cf573famr2338229edb.334.1645100539763;
        Thu, 17 Feb 2022 04:22:19 -0800 (PST)
Received: from [192.168.0.111] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id f22sm1142553ejl.46.2022.02.17.04.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 04:22:18 -0800 (PST)
Message-ID: <7329911c-3c44-d8e9-d8b0-aaf2fd1cedaf@kernel.org>
Date:   Thu, 17 Feb 2022 13:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH net-next] dt-binding: can: m_can: list Chandrasekar
 Ramakrishnan as maintainer
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220217113839.2311417-1-mkl@pengutronix.de>
 <3fb21251-a4de-2300-d1c6-5b98dd3c36d1@kernel.org>
 <20220217120601.dss4euvaazxtiyuh@pengutronix.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220217120601.dss4euvaazxtiyuh@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 17/02/2022 13:06, Marc Kleine-Budde wrote:
> On 17.02.2022 12:52:14, Krzysztof Kozlowski wrote:
>> On 17/02/2022 12:38, Marc Kleine-Budde wrote:
>>> Since Sriram Dash's email bounces, change the maintainer entry to
>>> Chandrasekar Ramakrishnan. Chandrasekar Ramakrishnan is already listed
>>> as a maintainer in the MAINTAINERS file.
>>>
>>> Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> index 3bc1ed39a0a5..b7f9803c1c6d 100644
>>> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> @@ -9,7 +9,7 @@ title: Bosch MCAN controller Bindings
>>>  description: Bosch MCAN controller for CAN bus
>>>  
>>>  maintainers:
>>> -  - Sriram Dash <sriram.dash@samsung.com>
>>> +  - Chandrasekar Ramakrishnan <rcsekar@samsung.com>
>>>  
>>
>> There was no activity from that email at all, so entry in Maintainers
>> and here will be half-dead... Since the change in maintainers in commit
>> ba23dc6dcab5 ("MAINTAINERS: Update MCAN MMIO device driver maintainer")
>> , Chandrasekar did not provide any reviews/acks/commits.
>>
>> Dear Chandrasekar,
>> Are you planning to perform maintainer activities on this driver?
> 
> At least Chandrasekar just send an email, willing to do maintainer
> duties, it was HTML only so it probably has not hit the mailing
> lists....
> 

Emails in HTML are the best. :)

Anyway, this sounds good then. FWIW:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
