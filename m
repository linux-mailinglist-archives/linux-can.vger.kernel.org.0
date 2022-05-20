Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CD952EC91
	for <lists+linux-can@lfdr.de>; Fri, 20 May 2022 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349506AbiETMsx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 May 2022 08:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349498AbiETMsv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 May 2022 08:48:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE1E1668B0
        for <linux-can@vger.kernel.org>; Fri, 20 May 2022 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653050931; x=1684586931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oe71NWIN9DqmtuqfAkiqaC3nWpVt0Kj1k2yHsngEmxY=;
  b=Ueey2+cTJ0qPlBEIQVogYFpEpR31dMNIYaPIDG3M0thdFFxvHwGmIhkQ
   L6CrydxA6TmpASGPXW3PHSnccvkOAp5ryr8zR2Rxa6pwIFfCEjWRaa2v+
   +CWMlCFAxE3VnMqUXttybL+aTbuOlO3u0BSO973i0GxaRiVOB+7wM5ch8
   hj5Rjah5tcrd4yj0cnL/MD9zjocRPlH1IFnDstNIN3y78XTaUIoiNkCXL
   ArT2OHVYWb3KKFMsjhqchYQGw0a+WJCkMVykgVYng7VIe6/I+zmJ+0FN0
   ICAcEfYN2k8ghUMx9T8v0Phuj8LfurSJ1V/+51aVl/grZljIJiIsFPsTo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="335653350"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="335653350"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 05:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="546666455"
Received: from mylly.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga006.jf.intel.com with ESMTP; 20 May 2022 05:48:48 -0700
Message-ID: <29930b66-d02e-411a-d6f5-4f09119f3f1e@linux.intel.com>
Date:   Fri, 20 May 2022 15:48:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: PCH_CAN removal?
Content-Language: en-US
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Chee Hou Ong <chee.houx.ong@intel.com>,
        Aman Kumar <aman.kumar@intel.com>,
        Pallavi Kumari <kumari.pallavi@intel.com>,
        Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
        Masayuki Ohtake <masa-korg@dsn.okisemi.com>
References: <20220513130819.386012-1-mkl@pengutronix.de>
 <20220513130819.386012-2-mkl@pengutronix.de>
 <20220513102145.748db22c@kernel.org>
 <2637cf42-b7da-a862-c599-ce418645629b@linux.intel.com>
 <03e3db49-1e56-1e34-ba8d-72ca06019287@hartkopp.net>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <03e3db49-1e56-1e34-ba8d-72ca06019287@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi

On 5/19/22 22:15, Oliver Hartkopp wrote:
> In fact there is a pch_can (PCI) driver which was used in an Intel 
> embedded setup "Topcliff PCH" ~11 years ago. The driver was originally 
> contributed by OKI.
> 
> And I was pretty sure that this driver implements a C_CAN IP core with a 
> PCI binding which is now implemented in the C_CAN_PCI driver.
> 
> As I do not have that hardware anymore it would be interesting to see if 
> you could bring the PCH board to life with the C_CAN_PCI driver?!?
> 
> That would allow us to remove the (then definitely) obsolete pch_can 
> driver.
> 
I'm afraid we don't have that HW either here locally :-(

Jarkko
