Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4334B9F67
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 12:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbiBQLwd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 06:52:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiBQLwc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 06:52:32 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50F88798;
        Thu, 17 Feb 2022 03:52:18 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id q17so9192370edd.4;
        Thu, 17 Feb 2022 03:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VmtBGHwco59SApsdSaFegOS+IiB4uRo+omhA1Imoo6g=;
        b=Ikr8dZyqNAo6rFe+pdsVruj2Nmm4ZsjZk8vBDJ9vDChPiCnfyTaJbp856rJUMzBJLn
         kGM3N4ARB1qtyx8bnLE24gUfrACE4TeVvkzSewFH9TJOX1FfSmugr46B3apI/rxRsYu/
         J+WTUC1BUS3+Si4vv4FNop9YP8/8+6bOR3S8MNxiv6wrbKHcc6TDCcJb6uE0JDb1KeJv
         ZkCmaeBLCf+pOf4p1hSRdTTQa14ppoctyPDawjczvGE0yt4Ey5lqjZkEiiCtuQlfbo9i
         YdS47HzwelvzR5qAumOPNu2jXd5EECeyEuL5ZBNvMXhbTbrLSOBHLs4lH5fjxCcgOV+T
         RwaA==
X-Gm-Message-State: AOAM532lPAdyALfHlXm90H+HINPi23qAA2Y05EtHOLWRLSqJiFDgqWzZ
        li622WdYKk5aNC+MvWCjtRI=
X-Google-Smtp-Source: ABdhPJznLgihgNXdPm0yNb1hEk4JvDTiE5cNlwToVk4V/WWp0pRpGbD7XR6X8z3lYsY6URK5+UlpzA==
X-Received: by 2002:a05:6402:4309:b0:410:db71:b5ce with SMTP id m9-20020a056402430900b00410db71b5cemr2228597edc.432.1645098736555;
        Thu, 17 Feb 2022 03:52:16 -0800 (PST)
Received: from [192.168.0.111] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id u23sm671418edo.64.2022.02.17.03.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 03:52:15 -0800 (PST)
Message-ID: <3fb21251-a4de-2300-d1c6-5b98dd3c36d1@kernel.org>
Date:   Thu, 17 Feb 2022 12:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH net-next] dt-binding: can: m_can: list Chandrasekar
 Ramakrishnan as maintainer
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220217113839.2311417-1-mkl@pengutronix.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220217113839.2311417-1-mkl@pengutronix.de>
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

On 17/02/2022 12:38, Marc Kleine-Budde wrote:
> Since Sriram Dash's email bounces, change the maintainer entry to
> Chandrasekar Ramakrishnan. Chandrasekar Ramakrishnan is already listed
> as a maintainer in the MAINTAINERS file.
> 
> Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index 3bc1ed39a0a5..b7f9803c1c6d 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -9,7 +9,7 @@ title: Bosch MCAN controller Bindings
>  description: Bosch MCAN controller for CAN bus
>  
>  maintainers:
> -  - Sriram Dash <sriram.dash@samsung.com>
> +  - Chandrasekar Ramakrishnan <rcsekar@samsung.com>
>  

There was no activity from that email at all, so entry in Maintainers
and here will be half-dead... Since the change in maintainers in commit
ba23dc6dcab5 ("MAINTAINERS: Update MCAN MMIO device driver maintainer")
, Chandrasekar did not provide any reviews/acks/commits.

Dear Chandrasekar,
Are you planning to perform maintainer activities on this driver?

Best regards,
Krzysztof
