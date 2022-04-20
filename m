Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3E509218
	for <lists+linux-can@lfdr.de>; Wed, 20 Apr 2022 23:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356530AbiDTVcN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Apr 2022 17:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382508AbiDTVcJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Apr 2022 17:32:09 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206A9488AB
        for <linux-can@vger.kernel.org>; Wed, 20 Apr 2022 14:29:21 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 8A5CA30B2944;
        Wed, 20 Apr 2022 23:28:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=ye8gt
        BwO4j+381uZDcBUMsVvkBfemF4Hfcgjz4T8N4M=; b=aUkGV2z83rA3oTrd2169B
        TBYvMdtJJuf+U6HHLqn1uXsUj8yrIWZulaibHj5uuhM3v92wKmoeWsLssj2PVtcz
        bacFaeNdi6V/PnhZz4UwSw/YbZPuRPfZUL1MKszuvv3sb2rD0WoR9JLpA6avi669
        obklyrKYT2uwqipoS/NEABSh2jV1TmY/qQO1sGvhmJHILVA10+AFExJVVWRaCydw
        nbOlK/IRVbnRdUlBOLI6+CUd40sUg0B8VoYtjuAxtv+RGskFlzPVjG//ukKvNOAX
        PjTJwNGB1bIA1cN+TDGt87fVdv4viblBjz7dcUQIqGL24ARx13lfputwH9mE5tA8
        w==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 9BAEF30AE004;
        Wed, 20 Apr 2022 23:28:47 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 23KLSlfo031601;
        Wed, 20 Apr 2022 23:28:47 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 23KLSlik031600;
        Wed, 20 Apr 2022 23:28:47 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v8 0/7] CTU CAN FD open-source IP core SocketCAN driver, PCI, platform integration and documentation
Date:   Wed, 20 Apr 2022 23:28:46 +0200
User-Agent: KMail/1.9.10
Cc:     "Marc Kleine-Budde" <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, Carsten Emde <c.emde@osadl.org>,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>,
        Drew Fustini <pdp7pdp7@gmail.com>,
        Mataj Vasilevski <vasilmat@fel.cvut.cz>
References: <cover.1647904780.git.pisa@cmp.felk.cvut.cz> <20220419153530.w2iovki72udt4o6q@pengutronix.de> <ebd3822c-9711-4125-b2a8-f1d5f15c3b65@hartkopp.net>
In-Reply-To: <ebd3822c-9711-4125-b2a8-f1d5f15c3b65@hartkopp.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202204202328.47031.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver,

On Wednesday 20 of April 2022 18:40:18 Oliver Hartkopp wrote:
> On 19.04.22 17:35, Marc Kleine-Budde wrote:
> > On 06.04.2022 10:20:42, Pavel Pisa wrote:
> >> I have missed timing for 5.18 but v5.18-rc1 is out so I would be
> >> happy if we do not miss 5.19 merge window at least with minimal version.
> >
> > I've taken the patch (almost) as is, I marked both can_bittiming_const
> > static, as sparse complained about that and I changed the order of two
> > variable declarations to look nicer :)
> >
> > Looking forward for more patches!
>
> The patches now landed in net-next \o/

This is a big day...

> But while checking the automatic review results from Patchwork here ...
>
> https://patchwork.kernel.org/project/netdevbpf/list/?series=&submitter=7454
>&state=*&q=CTU+CAN+FD&archive=&delegate=
>
> ... it looks like that at least the two red 'failed' markers should be
> addressed in follow up patches.
>
> The 'inline' warnings are easy to fix:
>
> https://patchwork.hopto.org/static/nipa/633430/12818712/source_inline/stder

If it means that no local function should be marked as inline if they
are in C file then inline removal is fully OK and according to current
compilers behavior probably comletely equivalent.

> But the module_param()'s in
>
> https://patchwork.hopto.org/static/nipa/633430/12818710/module_param/stderr
>
> should probably be revisited, whether the parameters (PCI/MSI and
> 'second IP core') could be handled by some automatic detection.

The situation is handled automatically. The parameters are there
only for situation when there is problem with PCIe design
on the FPGA side to allow disable MSI interrupts and test
if without that FPGA behaves correctly. It is great help
to debug problems. In my case, if I remember well, problem was
that some reference clocks has not been connected into core
so it could sync for CPU initiated transfers and for MSI
own initiated it failed horribly.

> Or did I miss something that makes these module parameters really
> necessary?

They can go away for normal use. They are help for those who want
to debug problems of CTU CAN FD core connection to PCIe FPGA design
to test and identify one of possible sources problems sources in
in the PCIe core setup and clocking. But that can be kept as separate
patches for debugging purposes. Parameters can be connected directly
to instances in sys or tuned some other way as well. But I think
that they do no belong to netling or something networking
related. It is strictly related to hardware and module load testing
after magic sequence to get rid of broken test FPGA design
and rescan for newly loaded Intel/Altera FPGA design

https://gitlab.fel.cvut.cz/canbus/pcie-ctucanfd/-/blob/master/scripts/db4cgx15-program
https://gitlab.fel.cvut.cz/canbus/pcie-ctucanfd/-/blob/master/scripts/test-ip-read

Device reapears after

echo 1 > /sys/bus/pci/rescan

then driver can be connected and tested.

But I prepare patch to get remove these debug options when it is preferred.

I expect that we test net-next soon and Mataj Vasilevski prepares
patches for timestamping. Probably optional/controlled by some
compile time option. Again it is good to have option to eliminate
possible source of problems. The base has been tested really many
times but addons are relatively new.

Best wises,

                Pavel
--
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

