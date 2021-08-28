Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348963FA46B
	for <lists+linux-can@lfdr.de>; Sat, 28 Aug 2021 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhH1Hwc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 28 Aug 2021 03:52:32 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:46689 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhH1Hwb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 28 Aug 2021 03:52:31 -0400
Received: by mail-pf1-f175.google.com with SMTP id m6so71302pfh.13;
        Sat, 28 Aug 2021 00:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wqL87jp9NAcmtPmdcijAMjQVRVrPdPqiMuKQlptPl0=;
        b=sSzUCzJTvT8zOiBbIXtzKEUsGWIh01OjtgJ3ZSnm/W6KidBfJIEQUVm9YgBCCZ0B2G
         3LfbwsJ15XwICuyk1HgdEu0/Pyj1XQkwg/ux7Lu8Ru6X8/UiVbIAWFItfe/zOpkHNKVh
         +06JOyPpZqQ1NPTLrmyrOjex/JoI7+uKCr7/V5vSU7jk4n2Av3ThCrO5XL6UFS8uK5Nc
         6HKTrJRSkA7Z2oU++uLlaqJ220PbEtKP1euuF3/je4xWcajRCXFFCkb/w4s5R9OCCN63
         UUh2oikVfOsy2CXwyOXSbHzssy/W948m1ap0DSHavwvADMDYbdyoztY34nxKaeS6Rqrd
         swTw==
X-Gm-Message-State: AOAM530VIC8CCA206lUgyFCjgwEGdXevddSJS7sCr0xtxoXde5Z3pUNK
        JrSQNqn7o7PNljdT5Bg+jYtV4u1eIDoiTaifQng=
X-Google-Smtp-Source: ABdhPJzlWxQATFXoMY9VVsoEDSkf3mluUAWqH2Gb3/0mV7ZXmjgNJPsIbgwTwOCchGFF36dFdnXFPeS1zWZD/wBHykA=
X-Received: by 2002:a62:7c55:0:b0:3f2:7ea0:93bc with SMTP id
 x82-20020a627c55000000b003f27ea093bcmr7902699pfc.36.1630137100882; Sat, 28
 Aug 2021 00:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210827163015.3141722-1-keescook@chromium.org> <20210827163015.3141722-3-keescook@chromium.org>
In-Reply-To: <20210827163015.3141722-3-keescook@chromium.org>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 28 Aug 2021 16:51:29 +0900
Message-ID: <CAMZ6RqJjD1_eZRnKEb8AvKOTua-WCRbATXEBbKWcD4mY9TD_hQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] treewide: Replace open-coded flex arrays in unions
To:     Kees Cook <keescook@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Luca Coelho <luciano.coelho@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-crypto@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        linux-scsi@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        bpf@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Packard <keithp@keithp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 28 Aug 2021 at 01:30, Kees Cook <keescook@chromium.org> wrote:
> In support of enabling -Warray-bounds and -Wzero-length-bounds and
> correctly handling run-time memcpy() bounds checking, replace all
> open-coded flexible arrays (i.e. 0-element arrays) in unions with the
> DECLARE_FLEX_ARRAY() helper macro.
>
> This fixes warnings such as:
>
> fs/hpfs/anode.c: In function 'hpfs_add_sector_to_btree':
> fs/hpfs/anode.c:209:27: warning: array subscript 0 is outside the bounds of an interior zero-length array 'struct bplus_internal_node[0]' [-Wzero-length-bounds]
>   209 |    anode->btree.u.internal[0].down = cpu_to_le32(a);
>       |    ~~~~~~~~~~~~~~~~~~~~~~~^~~
> In file included from fs/hpfs/hpfs_fn.h:26,
>                  from fs/hpfs/anode.c:10:
> fs/hpfs/hpfs.h:412:32: note: while referencing 'internal'
>   412 |     struct bplus_internal_node internal[0]; /* (internal) 2-word entries giving
>       |                                ^~~~~~~~
>
> drivers/net/can/usb/etas_es58x/es58x_fd.c: In function 'es58x_fd_tx_can_msg':
> drivers/net/can/usb/etas_es58x/es58x_fd.c:360:35: warning: array subscript 65535 is outside the bounds of an interior zero-length array 'u8[0]' {aka 'unsigned char[]'} [-Wzero-length-bounds]
>   360 |  tx_can_msg = (typeof(tx_can_msg))&es58x_fd_urb_cmd->raw_msg[msg_len];
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/net/can/usb/etas_es58x/es58x_core.h:22,
>                  from drivers/net/can/usb/etas_es58x/es58x_fd.c:17:
> drivers/net/can/usb/etas_es58x/es58x_fd.h:231:6: note: while referencing 'raw_msg'
>   231 |   u8 raw_msg[0];
>       |      ^~~~~~~
>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ayush Sawal <ayush.sawal@chelsio.com>
> Cc: Vinay Kumar Yadav <vinay.yadav@chelsio.com>
> Cc: Rohit Maheshwari <rohitm@chelsio.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Stanislaw Gruszka <stf_xl@wp.pl>
> Cc: Luca Coelho <luciano.coelho@intel.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
> Cc: linux-crypto@vger.kernel.org
> Cc: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-scsi@vger.kernel.org
> Cc: linux-can@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # drivers/net/can/usb/etas_es58x/*
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/crypto/chelsio/chcr_crypto.h              | 14 +++++++++-----
>  drivers/net/can/usb/etas_es58x/es581_4.h          |  2 +-
>  drivers/net/can/usb/etas_es58x/es58x_fd.h         |  2 +-
>  drivers/net/wireless/ath/ath10k/htt.h             |  7 +++++--
>  drivers/net/wireless/intel/iwlegacy/commands.h    |  6 ++++--
>  drivers/net/wireless/intel/iwlwifi/dvm/commands.h |  6 ++++--
>  drivers/net/wireless/intel/iwlwifi/fw/api/tx.h    |  6 ++++--
>  drivers/scsi/aic94xx/aic94xx_sds.c                |  6 ++++--
>  fs/hpfs/hpfs.h                                    |  8 ++++----
>  include/linux/filter.h                            |  6 ++++--
>  include/scsi/sas.h                                | 12 ++++++++----
>  include/uapi/rdma/rdma_user_rxe.h                 |  4 ++--
>  include/uapi/sound/asoc.h                         |  4 ++--
>  13 files changed, 52 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/crypto/chelsio/chcr_crypto.h b/drivers/crypto/chelsio/chcr_crypto.h
> index e89f9e0094b4..c7816c83e324 100644
> --- a/drivers/crypto/chelsio/chcr_crypto.h
> +++ b/drivers/crypto/chelsio/chcr_crypto.h
> @@ -222,8 +222,10 @@ struct chcr_authenc_ctx {
>  };
>
>  struct __aead_ctx {
> -       struct chcr_gcm_ctx gcm[0];
> -       struct chcr_authenc_ctx authenc[];
> +       union {
> +               DECLARE_FLEX_ARRAY(struct chcr_gcm_ctx, gcm);
> +               DECLARE_FLEX_ARRAY(struct chcr_authenc_ctx, authenc);
> +       };
>  };
>
>  struct chcr_aead_ctx {
> @@ -245,9 +247,11 @@ struct hmac_ctx {
>  };
>
>  struct __crypto_ctx {
> -       struct hmac_ctx hmacctx[0];
> -       struct ablk_ctx ablkctx[0];
> -       struct chcr_aead_ctx aeadctx[];
> +       union {
> +               DECLARE_FLEX_ARRAY(struct hmac_ctx, hmacctx);
> +               DECLARE_FLEX_ARRAY(struct ablk_ctx, ablkctx);
> +               DECLARE_FLEX_ARRAY(struct chcr_aead_ctx, aeadctx);
> +       };
>  };
>
>  struct chcr_context {
> diff --git a/drivers/net/can/usb/etas_es58x/es581_4.h b/drivers/net/can/usb/etas_es58x/es581_4.h
> index 4bc60a6df697..667ecb77168c 100644
> --- a/drivers/net/can/usb/etas_es58x/es581_4.h
> +++ b/drivers/net/can/usb/etas_es58x/es581_4.h
> @@ -192,7 +192,7 @@ struct es581_4_urb_cmd {
>                 struct es581_4_rx_cmd_ret rx_cmd_ret;
>                 __le64 timestamp;
>                 u8 rx_cmd_ret_u8;
> -               u8 raw_msg[0];
> +               DECLARE_FLEX_ARRAY(u8, raw_msg);
>         } __packed;
>
>         __le16 reserved_for_crc16_do_not_use;
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.h b/drivers/net/can/usb/etas_es58x/es58x_fd.h
> index ee18a87e40c0..e33003f96e5e 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_fd.h
> +++ b/drivers/net/can/usb/etas_es58x/es58x_fd.h
> @@ -228,7 +228,7 @@ struct es58x_fd_urb_cmd {
>                 struct es58x_fd_tx_ack_msg tx_ack_msg;
>                 __le64 timestamp;
>                 __le32 rx_cmd_ret_le32;
> -               u8 raw_msg[0];
> +               DECLARE_FLEX_ARRAY(u8, raw_msg);
>         } __packed;
>
>         __le16 reserved_for_crc16_do_not_use;
> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
> index ec689e3ce48a..a6de08d3bf4a 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.h
> +++ b/drivers/net/wireless/ath/ath10k/htt.h
> @@ -1674,8 +1674,11 @@ struct htt_tx_fetch_ind {
>         __le32 token;
>         __le16 num_resp_ids;
>         __le16 num_records;
> -       __le32 resp_ids[0]; /* ath10k_htt_get_tx_fetch_ind_resp_ids() */
> -       struct htt_tx_fetch_record records[];
> +       union {
> +               /* ath10k_htt_get_tx_fetch_ind_resp_ids() */
> +               DECLARE_FLEX_ARRAY(__le32, resp_ids);
> +               DECLARE_FLEX_ARRAY(struct htt_tx_fetch_record, records);
> +       };
>  } __packed;
>
>  static inline void *
> diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
> index 89c6671b32bc..4a97310f8fee 100644
> --- a/drivers/net/wireless/intel/iwlegacy/commands.h
> +++ b/drivers/net/wireless/intel/iwlegacy/commands.h
> @@ -1408,8 +1408,10 @@ struct il3945_tx_cmd {
>          * MAC header goes here, followed by 2 bytes padding if MAC header
>          * length is 26 or 30 bytes, followed by payload data
>          */
> -       u8 payload[0];
> -       struct ieee80211_hdr hdr[];
> +       union {
> +               DECLARE_FLEX_ARRAY(u8, payload);
> +               DECLARE_FLEX_ARRAY(struct ieee80211_hdr, hdr);
> +       };
>  } __packed;
>
>  /*
> diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
> index 235c7a2e3483..75a4b8e26232 100644
> --- a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
> +++ b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
> @@ -1251,8 +1251,10 @@ struct iwl_tx_cmd {
>          * MAC header goes here, followed by 2 bytes padding if MAC header
>          * length is 26 or 30 bytes, followed by payload data
>          */
> -       u8 payload[0];
> -       struct ieee80211_hdr hdr[];
> +       union {
> +               DECLARE_FLEX_ARRAY(u8, payload);
> +               DECLARE_FLEX_ARRAY(struct ieee80211_hdr, hdr);
> +       };
>  } __packed;
>
>  /*
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> index 24e4a82a55da..66c5487e857e 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
> @@ -713,8 +713,10 @@ struct iwl_mvm_compressed_ba_notif {
>         __le32 tx_rate;
>         __le16 tfd_cnt;
>         __le16 ra_tid_cnt;
> -       struct iwl_mvm_compressed_ba_ratid ra_tid[0];
> -       struct iwl_mvm_compressed_ba_tfd tfd[];
> +       union {
> +               DECLARE_FLEX_ARRAY(struct iwl_mvm_compressed_ba_ratid, ra_tid);
> +               DECLARE_FLEX_ARRAY(struct iwl_mvm_compressed_ba_tfd, tfd);
> +       };
>  } __packed; /* COMPRESSED_BA_RES_API_S_VER_4 */
>
>  /**
> diff --git a/drivers/scsi/aic94xx/aic94xx_sds.c b/drivers/scsi/aic94xx/aic94xx_sds.c
> index 46815e65f7a4..5def83c88f13 100644
> --- a/drivers/scsi/aic94xx/aic94xx_sds.c
> +++ b/drivers/scsi/aic94xx/aic94xx_sds.c
> @@ -517,8 +517,10 @@ struct asd_ms_conn_map {
>         u8    num_nodes;
>         u8    usage_model_id;
>         u32   _resvd;
> -       struct asd_ms_conn_desc conn_desc[0];
> -       struct asd_ms_node_desc node_desc[];
> +       union {
> +               DECLARE_FLEX_ARRAY(struct asd_ms_conn_desc, conn_desc);
> +               DECLARE_FLEX_ARRAY(struct asd_ms_node_desc, node_desc);
> +       };
>  } __attribute__ ((packed));
>
>  struct asd_ctrla_phy_entry {
> diff --git a/fs/hpfs/hpfs.h b/fs/hpfs/hpfs.h
> index d92c4af3e1b4..281dec8f636b 100644
> --- a/fs/hpfs/hpfs.h
> +++ b/fs/hpfs/hpfs.h
> @@ -409,10 +409,10 @@ struct bplus_header
>    __le16 first_free;                   /* offset from start of header to
>                                            first free node in array */
>    union {
> -    struct bplus_internal_node internal[0]; /* (internal) 2-word entries giving
> -                                              subtree pointers */
> -    struct bplus_leaf_node external[0];            /* (external) 3-word entries giving
> -                                              sector runs */
> +       /* (internal) 2-word entries giving subtree pointers */
> +       DECLARE_FLEX_ARRAY(struct bplus_internal_node, internal);
> +       /* (external) 3-word entries giving sector runs */
> +       DECLARE_FLEX_ARRAY(struct bplus_leaf_node, external);
>    } u;
>  };
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 472f97074da0..5ca52bfa5868 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -572,8 +572,10 @@ struct bpf_prog {
>         struct bpf_prog_aux     *aux;           /* Auxiliary fields */
>         struct sock_fprog_kern  *orig_prog;     /* Original BPF program */
>         /* Instructions for interpreter */
> -       struct sock_filter      insns[0];
> -       struct bpf_insn         insnsi[];
> +       union {
> +               DECLARE_FLEX_ARRAY(struct sock_filter, insns);
> +               DECLARE_FLEX_ARRAY(struct bpf_insn, insnsi);
> +       };
>  };
>
>  struct sk_filter {
> diff --git a/include/scsi/sas.h b/include/scsi/sas.h
> index 4726c1bbec65..64154c1fed02 100644
> --- a/include/scsi/sas.h
> +++ b/include/scsi/sas.h
> @@ -323,8 +323,10 @@ struct ssp_response_iu {
>         __be32 sense_data_len;
>         __be32 response_data_len;
>
> -       u8     resp_data[0];
> -       u8     sense_data[];
> +       union {
> +               DECLARE_FLEX_ARRAY(u8, resp_data);
> +               DECLARE_FLEX_ARRAY(u8, sense_data);
> +       };
>  } __attribute__ ((packed));
>
>  struct ssp_command_iu {
> @@ -554,8 +556,10 @@ struct ssp_response_iu {
>         __be32 sense_data_len;
>         __be32 response_data_len;
>
> -       u8     resp_data[0];
> -       u8     sense_data[];
> +       union {
> +               DECLARE_FLEX_ARRAY(u8, resp_data);
> +               DECLARE_FLEX_ARRAY(u8, sense_data);
> +       };
>  } __attribute__ ((packed));
>
>  struct ssp_command_iu {
> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
> index e283c2220aba..7f44d54bb0ab 100644
> --- a/include/uapi/rdma/rdma_user_rxe.h
> +++ b/include/uapi/rdma/rdma_user_rxe.h
> @@ -141,8 +141,8 @@ struct rxe_dma_info {
>         __u32                   sge_offset;
>         __u32                   reserved;
>         union {
> -               __u8            inline_data[0];
> -               struct rxe_sge  sge[0];
> +               __DECLARE_FLEX_ARRAY(__u8, inline_data);
> +               __DECLARE_FLEX_ARRAY(struct rxe_sge, sge);
>         };
>  };
>
> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
> index da61398b1f8f..053949287ce8 100644
> --- a/include/uapi/sound/asoc.h
> +++ b/include/uapi/sound/asoc.h
> @@ -240,8 +240,8 @@ struct snd_soc_tplg_vendor_array {
>  struct snd_soc_tplg_private {
>         __le32 size;    /* in bytes of private data */
>         union {
> -               char data[0];
> -               struct snd_soc_tplg_vendor_array array[0];
> +               __DECLARE_FLEX_ARRAY(char, data);
> +               __DECLARE_FLEX_ARRAY(struct snd_soc_tplg_vendor_array, array);
>         };
>  } __attribute__((packed));

Thanks for addressing all my remarks on the commit message.

FYI, I compared the assembly code before and after the patch:
both give the same output (as expected).

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
