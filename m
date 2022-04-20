Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20242508D81
	for <lists+linux-can@lfdr.de>; Wed, 20 Apr 2022 18:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380615AbiDTQnx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Apr 2022 12:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353698AbiDTQnv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Apr 2022 12:43:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E486D1C931
        for <linux-can@vger.kernel.org>; Wed, 20 Apr 2022 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1650472825;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=sWK9ucg+gfYj5IGYFr3hr83Z6MSuviTdsM958JleDY8=;
    b=pEZfclndpDolCaQ+cq195vywFWIOvb/tOwuoO7B7s/NVFQ73LJ/CVTQ3w5mtgJpd+I
    ghe++NceldWyuWSq4yy3mTzHl47ZLWzBCVKuizZbbJIr3ie3mAOwcBBxlSj6vshYoLxl
    mYlyXl2U5Ml1DM4okCbel15JuZJu53SnS+Zpop4g4XY8MpznG5jVrsKHB97Fr1RcgZ1g
    8tbl6y4ZVzIsiSeRv0O8nSJyvi19UfHqtSoh4r1xXXuN7j0Vfaq4/KxdK2eH94eIWTsF
    EPN3gYvsuBZNpzAlK7V5UMeVftVxOWjL7mZk69Uv2BriHX60bysu78JPpNxbyoahjxOh
    y36Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOug2krd4U1dg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b04::923]
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y3KGeO3sq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 20 Apr 2022 18:40:24 +0200 (CEST)
Message-ID: <ebd3822c-9711-4125-b2a8-f1d5f15c3b65@hartkopp.net>
Date:   Wed, 20 Apr 2022 18:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v8 0/7] CTU CAN FD open-source IP core SocketCAN driver,
 PCI, platform integration and documentation
Content-Language: en-US
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Carsten Emde <c.emde@osadl.org>,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>,
        Drew Fustini <pdp7pdp7@gmail.com>,
        Mataj Vasilevski <vasilmat@fel.cvut.cz>
References: <cover.1647904780.git.pisa@cmp.felk.cvut.cz>
 <202203220918.33033.pisa@cmp.felk.cvut.cz>
 <20220322092212.f5eaxm5k45j5khra@pengutronix.de>
 <202204061020.42943.pisa@cmp.felk.cvut.cz>
 <20220419153530.w2iovki72udt4o6q@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220419153530.w2iovki72udt4o6q@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Pavel, Martin, Ondrej,

On 19.04.22 17:35, Marc Kleine-Budde wrote:
> On 06.04.2022 10:20:42, Pavel Pisa wrote:

>> I have missed timing for 5.18 but v5.18-rc1 is out so I would be
>> happy if we do not miss 5.19 merge window at least with minimal version.
> 
> I've taken the patch (almost) as is, I marked both can_bittiming_const
> static, as sparse complained about that and I changed the order of two
> variable declarations to look nicer :)
> 
> Looking forward for more patches!

The patches now landed in net-next \o/

But while checking the automatic review results from Patchwork here ...

https://patchwork.kernel.org/project/netdevbpf/list/?series=&submitter=7454&state=*&q=CTU+CAN+FD&archive=&delegate=

... it looks like that at least the two red 'failed' markers should be 
addressed in follow up patches.

The 'inline' warnings are easy to fix:

https://patchwork.hopto.org/static/nipa/633430/12818712/source_inline/stderr

But the module_param()'s in

https://patchwork.hopto.org/static/nipa/633430/12818710/module_param/stderr

should probably be revisited, whether the parameters (PCI/MSI and 
'second IP core') could be handled by some automatic detection.

Or did I miss something that makes these module parameters really necessary?

Best regards,
Oliver



