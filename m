Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F624E4CC2
	for <lists+linux-can@lfdr.de>; Wed, 23 Mar 2022 07:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241895AbiCWGdj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Mar 2022 02:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiCWGdj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Mar 2022 02:33:39 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800E0716E8
        for <linux-can@vger.kernel.org>; Tue, 22 Mar 2022 23:32:10 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id q129so764046oif.4
        for <linux-can@vger.kernel.org>; Tue, 22 Mar 2022 23:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=CNNPGySxSq7bZ1La6vvay1kp1T7RaMnfdFjrr49KhAk=;
        b=ELHNnFp6MqSbFWD5yohJR2P6geJrnoRmAy99u/wb2i3YgbuP4pWakoRgQfTsGVZlvn
         zLTN0T624N4/lL25GMK9qfuRfPiJigFyNydERiaTexgqTI/XwdMF2uLn+oQY6Yv0SKPc
         9fDM/dzuYRq6DHijqM7s8dRKZ9B3qFT9YVKfGvkubS9pzTFGp+ptWDJ1xbaW35dktUYS
         vQMaYGrLqckC16Dn5dH0kAKCcO9G9lvi+YvGK4hyOnMiksWl+nkM2HvljeUfWO+bKqus
         e2w3/545UcSrcuUhEibwm9A9M8Z8TNTBNiSvHJqQS8nG/7p9h98oX7Y3hECJg4ch8kNB
         OmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=CNNPGySxSq7bZ1La6vvay1kp1T7RaMnfdFjrr49KhAk=;
        b=eHMTTw8pX1MLrOxp/kX96IdD/Iji94CgnFxO64W5H/SCtt4+VATmLcBfnpgwso2M1o
         jWMPoLBvcUPZKal5eT4tTwB48Gna1MHF2t0RdWYPhGdBebG9lKp2hgr5Rnm1MhUMySkP
         Y9Yw47Slt+R3BvYxS6It7EvbM7Mfmy0QXike9IK3NNl0EqrEJcpU5RGbDODYvwpxhkLV
         vWr9OGSqA8qSb18QZXy/70G7IC0HDK8gW0iaqqAqCTEdXfRZRhvUGVfiVM4X/TdKSgtf
         +y06dLo+coHAo5bimbAB1fedYfNc4iYsD82Yri3mgeGO4YZqbjgpZ8JSGCXNY3aElv2A
         WoOw==
X-Gm-Message-State: AOAM530BExLqveEKEvPG3/xRSVgom9kDGUf9L+cZUHQDZRqIyEcTwvd9
        k0oElij+MVwyGgywdowoauv4dmBfinsJk0buFpk=
X-Google-Smtp-Source: ABdhPJxwyT/N30ellZDc2KKS1Sx/fwQoRUjXkm5cAsQUvi6gnhJRO0h3xobcDWI8XIWK3kmGB7T+ggZxEkBhcyOBm/8=
X-Received: by 2002:a05:6808:e8b:b0:2d9:d744:1eee with SMTP id
 k11-20020a0568080e8b00b002d9d7441eeemr3868008oil.129.1648017129784; Tue, 22
 Mar 2022 23:32:09 -0700 (PDT)
MIME-Version: 1.0
Sender: mrslila88haber@gmail.com
Received: by 2002:a4a:e08f:0:0:0:0:0 with HTTP; Tue, 22 Mar 2022 23:32:09
 -0700 (PDT)
From:   "Dr. Nance Terry Lee" <nance173terry@gmail.com>
Date:   Wed, 23 Mar 2022 06:32:09 +0000
X-Google-Sender-Auth: VggOCyHB4u8Az8-7N0FAK_YFxMA
Message-ID: <CAODWenbVoYBDWP2tVL33-r+qC_C2ZzXk1s3bv0Kdd_yszEWk7g@mail.gmail.com>
Subject: Hello My Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:244 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrslila88haber[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.9 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello My Dear Friend,

I am Dr. Nance Terry Lee, the United Nations Representative Washington
-DC - USA.
I hereby inform you that your UN pending compensation funds the sum of
$4.2million has been approved to be released to you through Diplomatic
Courier Service.

In the light of the above, you are advised to send your full receiving
information as below:

1. Your full name
2. Full receiving address
3. Your mobile number
4. Nearest airport

Upon the receipt of the above information, I will proceed with the
delivery process of your compensation funds to your door step through
our special agent, if you have any questions, don't hesitate to ask
me.

Kindly revert back to this office immediately.

Thanks.
Dr. Nance Terry Lee.
United Nations Representative
Washington-DC USA.
Tel: +1-703-9877 5463
Fax: +1-703-9268 5422
