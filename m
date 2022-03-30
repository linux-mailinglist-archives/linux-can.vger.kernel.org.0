Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4922C4EB872
	for <lists+linux-can@lfdr.de>; Wed, 30 Mar 2022 04:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbiC3Cs4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Mar 2022 22:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiC3Cs4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Mar 2022 22:48:56 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA7E170D99
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 19:47:12 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso13593540ioo.13
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 19:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=c/AsYAgXa09jRRBdsVfIgMgdrdrDOgAgx7n02rdZv2k=;
        b=eIVj1Cm/2bJlxvGCXZ5W8OP0HfgOcfUmwu9xbayx5/lVfeDeBZo9DmCA83L1oL8b4d
         jpGdfecALhdZbEoKtOCWxfLucC+cMmEvM2c4Kt/WyO2rBN66P+QYX1gOUgajcWNuhLEl
         XgSLQZsSNxnR2ObKJIOItbjbEhdtaRRJkm7dixjoAgemmaUdDl5vaid/e2f2OgVeC4WR
         VIYVOL5rRx3+1hDCe7L4NyavHYUZ4f9El9WUfvo4f308oT9aNi6lbbIl/4GtuAvnJxCx
         dfzF1SEO5eKOK+H3yXHMfvErXBvsB/w6MYNWXDG0fGxWocbZvrGvZ5s3A+FwpFUy8mpR
         EG0w==
X-Gm-Message-State: AOAM533SBSEXOOCtoxFy3IB5MNZdZd7gDDpGP+U+PknDTloK9R/i/sA6
        mh+Cy/3l60bwjlwA4OyGPnfnnKfHXDQYkPrO+sOFEVv/vb7O
X-Google-Smtp-Source: ABdhPJyLKogGkQhwexomYTMXE+Nt8nLtZvAyhenJjziFvfmxD+xP96aOw/RLJCAI+Z1zTpWHwd6N7DSJDxk+1StyqW9h3yrD+LD2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1388:b0:323:78d7:4061 with SMTP id
 w8-20020a056638138800b0032378d74061mr4213954jad.152.1648608431768; Tue, 29
 Mar 2022 19:47:11 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:47:11 -0700
In-Reply-To: <PH0PR11MB588040F5F12E2E4A3432583CDA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3087f05db668ff8@google.com>
Subject: Re: [syzbot] memory leak in gs_usb_probe
From:   syzbot <syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com>
To:     linux-can@vger.kernel.org, qiang1.zhang@intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15dc8777700000

