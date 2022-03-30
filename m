Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F774EB864
	for <lists+linux-can@lfdr.de>; Wed, 30 Mar 2022 04:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbiC3ClD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Mar 2022 22:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbiC3Ck5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Mar 2022 22:40:57 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB14A94DE
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 19:39:09 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id y4-20020a6bd804000000b0064c68fa4f70so6730297iob.2
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 19:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MGY4ked8FrP/RDpFhZIyerD1Rqnm8bxFvDVSgecXTM0=;
        b=RLGu6UJS6U9R/HbXYydip2IG+40HJYMiV/tys1SqiPLSCIPpgNpQbGc97vitbVGVyz
         6mxzDY8n8ixx+54DfdWD2Scg0rXNPq8cvV5QRV64zNoey7+yMPYH6i7YnB1UWUYsYF5Y
         RRRpd4fXWWg3v1Ak9klTq3Mtulzyso7hAidBhqV3zFw1hdnJq6CKw9hWX2ud4MsoaiJS
         +S6T6+byu/XRTg7L8ciYh7ndBKLXpAG570De3IUV6U4S93BrEluPKhcydI9mKReRh+Ph
         /6SvsoHf0dlGgQ6ZZA4UyNa0sDEBWRcrSccsxEsnKseDeb2g3B3WgMWggMF9ZyR6Uf3O
         m5LA==
X-Gm-Message-State: AOAM530VcucooCbwQjNbxj47oZQqmMnmPcIMo7Vfd4p/OhnaaWOGyXYk
        MGL0LtWN4x2DXK9sYDQSU+aw4Dtr4ZBEshprtDqmLSzDqxNj
X-Google-Smtp-Source: ABdhPJyUEaP285XNxj6Cem8fvK5XyzQTUM+P5p8p/WLmotpZHrPuhjFTZSz2WN85+3r0Rj9bcw/GMtIqbVBAaoLLA24d9KdGtmei
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c7:b0:323:9349:fc42 with SMTP id
 j7-20020a05663822c700b003239349fc42mr1407731jat.312.1648607949128; Tue, 29
 Mar 2022 19:39:09 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:39:09 -0700
In-Reply-To: <PH0PR11MB5880D33225C1E8A684BCFF64DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e8c1805db6673e2@google.com>
Subject: Re: [syzbot] memory leak in gs_usb_probe
From:   syzbot <syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, pabeni@redhat.com, pfink@christ-es.de,
        qiang1.zhang@intel.com, syzkaller-bugs@googlegroups.com,
        wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/can/usb/gs_usb.c
patch: **** unexpected end of file in patch



Tested on:

commit:         c2528a0c Add linux-next specific files for 20220329
git tree:       linux-next
dashboard link: https://syzkaller.appspot.com/bug?extid=4d0ae90a195b269f102d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=166a33ab700000

