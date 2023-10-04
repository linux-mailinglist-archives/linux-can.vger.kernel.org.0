Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEEE7B7C0F
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbjJDJ0i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbjJDJ02 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:26:28 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89550AC
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:26:24 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id a1e0cc1a2514c-7ae1a075fc5so942336241.3
        for <linux-can@vger.kernel.org>; Wed, 04 Oct 2023 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696411583; x=1697016383; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnmQl8sSvmxsT7TJmuRyppmBVP3pNDIYT+rwhG+8TfE=;
        b=CLEuiewf476OKXjz148Nz8WD7Z9OVoTOSu7wToYsoJQuOJVP6rCNTRd/lMT8jvGydS
         t/dmU1jvue1wuBrzAnoIlbzjTk+oyRQQRF4mhpnOh0FxlLUry5n6QA62wSOrldkXzeIC
         kOQ3u3ZwFOvTwrJHtPcgKjHd9n9FjXBZ0WVh00ct9PHiMiCzoFHTnsesYhzKK3NMm/Vk
         MBcfSSBS2loQk79iXYDtm3zGtamjQ8jOjMuSZ0MGXz9hQqw4blfXUBCiMcBO3F0Js5rB
         qQn8lz8xEpV+K7kvDGW44uOPZElH0Tnia8FNW6lxiiFwTaLiLu1cGA4gWEg+dqJEmxqi
         eS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696411583; x=1697016383;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnmQl8sSvmxsT7TJmuRyppmBVP3pNDIYT+rwhG+8TfE=;
        b=IUVylXd1Um7SH1JX6C5gKL0T7KvDcpMvNgA0jYf1z7qk1iryMKQ7xideZXhYSFOqci
         VRJ8wxwW70jh/saR/cpslCkuNAekLVMmaWvnl/lnBBIVhC86QU/pbm5Kiil1V/6Sm8ln
         hmyhUwttLPXa4o/3VlytL1dWo9gJ1wMlmMxdzyDl9Obt+wXLfEf177Fa7Py7jaCgFQAI
         SVOu5YZ2B9s3hicX9o7O6jSopIsLl0deNVwm1tCeW+/YdEzSqmVcmkZ1vXyKz0ZCdJ0J
         Jqe8y5a/iij3jfipIfPpY+gB/M6vcKz5iCHDNSnC9aausdHWvHbwpYc8kgRzuj0v0c8C
         z8BA==
X-Gm-Message-State: AOJu0YyamYPDV0fXClXvEylgtfUMx4n5G3YOtrGi4qJiVkE6fRMaAqmf
        O+8umtrlsd/cxZ31jEIuWBSV4z/mVWOr2k30zNo=
X-Google-Smtp-Source: AGHT+IElgifLEqyMo5+G69+LPAEj4Ob8ITPveCMbgBKJR1+08uJtNCdlhbxFdaRTV12QFj/RP3hTzCL3E1x/ZJWpqAU=
X-Received: by 2002:a1f:cb42:0:b0:49b:289a:cc3f with SMTP id
 b63-20020a1fcb42000000b0049b289acc3fmr1483618vkg.3.1696411583584; Wed, 04 Oct
 2023 02:26:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:bdd5:0:b0:3fc:7951:2279 with HTTP; Wed, 4 Oct 2023
 02:26:22 -0700 (PDT)
Reply-To: rrr.wilsson@gmail.com
From:   "R.Wilson" <97080305r@gmail.com>
Date:   Wed, 4 Oct 2023 02:26:22 -0700
Message-ID: <CAMjKm1fw6PqF50BkSEAwqP3RJzz12o43UJB=4J4dC7-3JmsRLw@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:941 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5206]
        *  0.7 FROM_STARTS_WITH_NUMS From: starts with several numbers
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [97080305r[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Can you help the people of God?
I wish to establish a charity foundation to help the poor in your
country under your care, Can you help to build this project in your
country? I am willing to donate my late husband's funds to the less
privileges for the help of mankind.please get back to me for full
details
