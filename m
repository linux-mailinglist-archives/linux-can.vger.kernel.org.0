Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D34EB80F
	for <lists+linux-can@lfdr.de>; Wed, 30 Mar 2022 03:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbiC3CAG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Mar 2022 22:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbiC3CAE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Mar 2022 22:00:04 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90EB1E1
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 18:58:19 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id f18-20020a926a12000000b002be48b02bc6so10615605ilc.17
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 18:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IseIOXkjbiVc9FdIOxRiy+s/BeCwVlVVfBMa+vQ5dYY=;
        b=N+gnIUKq2hyE/SmTiavoo3JVJVKfDfvl6hUGjadCX6EkGDUbuOBKNb2O2hkzCNPonp
         AEOHkfJgbzMM3h8w1xeKy/WXJvDXRIwiLkM04TvHvlhZTLAnj4Np0Gw6ETb185lb3Oj+
         vaFXlPly6onkaxAm8k9wfdL/h+jaIJim5SjWZJxXxF8eCinJ3pMuVSrtl9eo6uJW8LT7
         1hV3ph9IS/cokMHWBajF0DuxxH2eTldjzrQozeJunKfUHpepMXQBCf/MqdInTCbCi6RR
         6k4/X5Z/SfSEddL0k4n9NSKMDTzucxwpjDY6iBiAZ9Gqj7vzkhbTBp4hVHmOiZqQgBWd
         86IA==
X-Gm-Message-State: AOAM533rHPp22tYPupAISX3E2JymyTouAD9sHQAqmFY1v5X2OVusjl5c
        /NdbF73nTepqW1HADe5f3blCGGmDEYtZmee3HJiQBTTs5S9l
X-Google-Smtp-Source: ABdhPJzZsTbs5V+jGlGVIPmp5OJTNAz4szJdfUPGD5BTq859VgJKGagheZr0km8YyX41O8llp18wpjR3unLlE2QdRCrpcxbY+eVR
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2101:b0:319:d53e:5663 with SMTP id
 n1-20020a056638210100b00319d53e5663mr18244887jaj.115.1648605498964; Tue, 29
 Mar 2022 18:58:18 -0700 (PDT)
Date:   Tue, 29 Mar 2022 18:58:18 -0700
In-Reply-To: <PH0PR11MB5880D90EDFAA0A190D927914DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024006a05db65e1e4@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163e219b700000

