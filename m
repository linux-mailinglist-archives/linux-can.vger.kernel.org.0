Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7935F42B7
	for <lists+linux-can@lfdr.de>; Tue,  4 Oct 2022 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiJDMJ7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Oct 2022 08:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJDMJ5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2022 08:09:57 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7C1263E
        for <linux-can@vger.kernel.org>; Tue,  4 Oct 2022 05:09:55 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id y2so8177968qkl.11
        for <linux-can@vger.kernel.org>; Tue, 04 Oct 2022 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=N/GSbPnALToZPDvWcwsyZl8roxv+rx6jEvhzi+rz9/I=;
        b=RTneg+MYbqpdaR6DcxBkEgRYdkdGT/nADaTZZPJZhvDAxzQPMs7m0A2kPVP6DINta4
         WdfZUL4yQK8pw0FZOhVIXMhp1fk9pH+eJbK5Tqx+MCmSr1USpUcUoa7R9Rf1767wKqb1
         AeRT7DAaIvyy4+h7qUbsua/2q1lWUfWr4n+TbCX0HX1HBcT0mBFzdtKd3JHTz9AnLfhH
         se3y1acPQeJ/o3ky7rz4qZHWhvekWf7ycSpF/dwpQiZiZ45k5LLkwa85BGasVUKsIZ2/
         +1ligvmFMYMCDNKBgIb8Zn3ysy2vpPj5fsOfXsfI+ZJWoW2WSBrDTNTf40maeocKHdhU
         iPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=N/GSbPnALToZPDvWcwsyZl8roxv+rx6jEvhzi+rz9/I=;
        b=sM3NyI4B8yDDvLuVFo8XmZcmM++pwchyXW34lNvgNehPfNRSOilzp124ApJQybJGai
         mt/EMm5BklXSuFzjJmwEBYALDe9Cm5LsLWUnn1Yuh/Nksg/cPJlfMxI97WqXXxFGm1AI
         VwYAA2KeVWu/CA+1NVGGagJjJc0ZIXEDUZZyAsGuPvbxGZUA3q5rIc/1okPMrOOCmQL+
         dNytSofxOa6jTcXXSdb9IGHFAODKrRRxTpBe2w9jfEavZnPjGvw8Hoes0jq3YWZHxBIq
         ZSL8x0/bZMF9IAclZK0tmTDi74opNMp3PNHx13oXQJ/4dUvWP24gtJjCEyfOtTT2N4pD
         O3Tg==
X-Gm-Message-State: ACrzQf3nZ5B1ttggdleA+DerKxPuco3Y/TMEFNMzs7+yRxORUWkKloEL
        bt2RX11+m5SjUgVvOIGP5jfUto4bVHibrdHz9/M=
X-Google-Smtp-Source: AMsMyM4c7UWZ/P//H5lPCULKTAbDFoUwMbX5ucMGGKxbqR2LU0v5E3jI+fDVx+oI/2ieimLC7TISfpZGVdvQ82KOyzs=
X-Received: by 2002:a05:620a:2789:b0:6cf:ba4b:28a6 with SMTP id
 g9-20020a05620a278900b006cfba4b28a6mr16512923qkp.520.1664885393869; Tue, 04
 Oct 2022 05:09:53 -0700 (PDT)
MIME-Version: 1.0
Sender: ogunmasaadesola@gmail.com
Received: by 2002:ad4:5baa:0:0:0:0:0 with HTTP; Tue, 4 Oct 2022 05:09:53 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Tue, 4 Oct 2022 05:09:53 -0700
X-Google-Sender-Auth: CPg-5DdLWHcHlje9aOZfg9L4guc
Message-ID: <CAEGnpV_nFDhqoNfYNonfNb8thmP+=uz5Ck+p1Qaea=ZhV5Uegg@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

-- 

Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply
me.
