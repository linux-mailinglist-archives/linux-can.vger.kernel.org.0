Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2472B1CE
	for <lists+linux-can@lfdr.de>; Sun, 11 Jun 2023 14:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjFKMPW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Jun 2023 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFKMPW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Jun 2023 08:15:22 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6F110CF
        for <linux-can@vger.kernel.org>; Sun, 11 Jun 2023 05:15:20 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 080018469B;
        Sun, 11 Jun 2023 14:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1686485718;
        bh=VCHUWEP9cNOmqNx+L0u14eMbCru9jtiGaaZDw0qtOKE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HpHEIbJ5g8zBtuy+gj9gVFV9wRqbZ4+EiVQk3ICFZ1x1v6j6mR3QWb6pg7cAih7UO
         RFYOXf6PHoYjiHT9YklZDiWPerERsB2r7DqXmaI1Fp7vSAJO5JLV/mG+q6+BPqneEA
         bH3mGlfIr5sZVJX5HvXTA/dZore3EuS1TrcuIOFKYDfMlu2gxLuZroGvCGU4sUKaw0
         JK1o0yU13YoAKEnpztqh+NMMjJWBz/B/kRA+sPdC+ljFte1Pv4OWPOBattRcbSQ18D
         m5YWIlEKwMEXTcQfnIlTWdy7dBhHOpVo0Y2kc+PaQXYRCTvhZgj3Nfbusf2t9GpqPy
         BzDStymidtUgQ==
Message-ID: <cb45bac8-2539-2226-f10f-fe017b05d18c@denx.de>
Date:   Sun, 11 Jun 2023 14:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] can: mcp251xfd: Increase poll timeout
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org,
        fedor.ross@ifm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, lgirdwood@gmail.com, mani@kernel.org,
        broonie@kernel.org, pabeni@redhat.com, wg@grandegger.com
References: <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
 <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
 <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <BL3PR11MB6484A68C2B2CFFAA44AD3E09FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJo=j7wsfOPsYRn++vMSnhKBuQAwckZ-u7qwjBdsb_d_g@mail.gmail.com>
 <BL3PR11MB64843D32844A848AAC7BFDF1FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqK266c+taxgUqd_2kSfbNDgTawkcthTaM+4JXpeLV0cfQ@mail.gmail.com>
 <BL3PR11MB64846AD5ACBC42C74D11DF7DFB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6Rq+M+nyxq2YaOVmVngTVZbAUHd4+YJUasvwyAkxiZJmxGw@mail.gmail.com>
 <20230517-shrunk-dinner-e6c43f73c936-mkl@pengutronix.de>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230517-shrunk-dinner-e6c43f73c936-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 5/17/23 09:15, Marc Kleine-Budde wrote:
> On 10.05.2023 20:19:38, Vincent Mailhol wrote:
> [...]
>> ISO 11898-1 is such a rabbit hole... sights...
> 
> How do we proceed?
> 
> I like Marek's approach of defining the delay first in the driver and
> then moving it to a common header in the second patch to facilitate
> backporting.
> 
> Do we agree on the maximum number of bits to wait in the worst case?

Is any further change expected from me to this patch ?
